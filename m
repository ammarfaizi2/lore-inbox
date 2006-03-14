Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751993AbWCNOLj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751993AbWCNOLj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 09:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751939AbWCNOLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 09:11:39 -0500
Received: from pproxy.gmail.com ([64.233.166.182]:58307 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751993AbWCNOLi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 09:11:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VPJZZqbtAvH9DuwpFo1dBEcuGlCAr0Fdajy1pCY8vVnz21ZnuXihz+oNDSGlGEW3VONxR5bxaSoPV3cdiA+yg/qMrqXOhyZooyF7PCbUc/3KS+PpOpDtOLUEIXzXeq2BtJ42wDxWFlFdAWzn3CZDxLupyoxCCdc4KWdD/3DrcsU=
Message-ID: <6bffcb0e0603140611w2961a15di@mail.gmail.com>
Date: Tue, 14 Mar 2006 15:11:38 +0100
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: 2.6.16-rc6-rt3
Cc: linux-kernel@vger.kernel.org, "Thomas Gleixner" <tglx@linutronix.de>
In-Reply-To: <20060314084658.GA28947@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060314084658.GA28947@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 14/03/06, Ingo Molnar <mingo@elte.hu> wrote:
> i have released the 2.6.16-rc6-rt3 tree, which can be downloaded from
> the usual place:
>
>    http://redhat.com/~mingo/realtime-preempt/
>
> this is a fixes-only release, which resolves a number of 2.6.16-rc6
> rebasing side-effects. The fixes are:
>
>  - futex crash fix (reported by Michal Piotrowski)

Problem solved.

>  - printk from rt-atomic context fix (Thomas Gleixner, reported by
>    Michal Piotrowski)

Problem solved.

Thanks.

Regards,
Michal

--
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
