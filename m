Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264626AbSJ3IhY>; Wed, 30 Oct 2002 03:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264627AbSJ3IhY>; Wed, 30 Oct 2002 03:37:24 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13585 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264626AbSJ3IhX>;
	Wed, 30 Oct 2002 03:37:23 -0500
Message-ID: <3DBF9BA5.6000100@pobox.com>
Date: Wed, 30 Oct 2002 03:43:17 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: torvalds@transmeta.com, Nikita Danilov <Nikita@namesys.com>,
       landley@trommello.org, linux-kernel@vger.kernel.org
Subject: Re: 2.5 merge candidate list, final version.  (End of "crunch time"
 series.)
References: <200210280534.16821.landley@trommello.org> <15805.27643.403378.829985@laputa.namesys.com> <3DBF9600.4060208@namesys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:

> We are going to submit a patch appropriate for inclusion as an 
> experimental FS on Halloween.   I hope you will forgive our pushing 
> the limit timewise, it is not by choice, but the algorithms we used to 
> more than double reiserfs V3 performance were, quite frankly, hard to 
> code.



Does your merge change the core code at all?  Does it add new syscalls?


