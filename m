Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262369AbSJVJk5>; Tue, 22 Oct 2002 05:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262370AbSJVJk5>; Tue, 22 Oct 2002 05:40:57 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50696 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262369AbSJVJk4>;
	Tue, 22 Oct 2002 05:40:56 -0400
Message-ID: <3DB51EA2.5060106@pobox.com>
Date: Tue, 22 Oct 2002 05:47:14 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Dillow <dillowd@y12.doe.gov>
CC: Christopher Keller <cnkeller@interclypse.net>,
       linux-kernel@vger.kernel.org
Subject: Re: 3COM 3C990 NIC
References: <1035002976.3086.4.camel@maranello.interclypse.net> <3DB4D9F8.F86ABA4@y12.doe.gov>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Dillow wrote:
> I have a completely reworked version that I expect to be able to release RSN.
> (I know, I know, some of you have heard that before... it just takes time to
> get people around here to sign off on these things. :/)
> 
> It will support zero-copy TCP, TCP segmentation offload, and when DaveM's
> IPSEC is in, I'll be able to do hardware offload for that as well.

Cool :)

Will you be submitting this for inclusion in the kernel?

And, what differences exists between the 3c59x and 3c90x hardware, and 
3c990?  Just IPSEC?

	JEff



