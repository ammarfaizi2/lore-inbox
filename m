Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261723AbUJYIdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbUJYIdd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 04:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261726AbUJYIak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 04:30:40 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28565 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261703AbUJYI0z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 04:26:55 -0400
Message-ID: <417CB8BD.5060708@pobox.com>
Date: Mon, 25 Oct 2004 04:26:37 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Kleen <ak@suse.de>
CC: torvalds@osdl.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 6/17] 4level support for i386
References: <417CAA05.mail3YL115DA5@wotan.suse.de>
In-Reply-To: <417CAA05.mail3YL115DA5@wotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Kleen wrote:
> 4level support for i386
> 
> Assembly code generated should be very similar to before because the 4th level
> just collapses.  Tested with 2 and 3 levels. 

lmbench performance notes?


