Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261544AbSKTQ6L>; Wed, 20 Nov 2002 11:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261559AbSKTQ6L>; Wed, 20 Nov 2002 11:58:11 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53518 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261544AbSKTQ6K>;
	Wed, 20 Nov 2002 11:58:10 -0500
Message-ID: <3DDBC0C5.1000306@pobox.com>
Date: Wed, 20 Nov 2002 12:05:09 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven French <sfrench@us.ibm.com>
CC: acc@CS.Stanford.EDU, linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] 16 more potential buffer overruns in 2.5.48
References: <OFF1AA16C4.904AD55A-ON87256C77.00529B26@us.ibm.com>
In-Reply-To: <OFF1AA16C4.904AD55A-ON87256C77.00529B26@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven French wrote:

> work.   It might have be more readable if it were defined as a  __u8



tiny pedantic point:  s/__u8/u8/ if it is kernel code

