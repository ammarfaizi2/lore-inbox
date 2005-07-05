Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261917AbVGEQZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261917AbVGEQZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 12:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbVGEQZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 12:25:19 -0400
Received: from zproxy.gmail.com ([64.233.162.205]:48490 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261917AbVGEQNE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 12:13:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LDfache8oSvUaoGlGhQrMqVZGzaJgV/pFPm/VeQcqFkGOfQKXguEvHYxZpmK1B9ua6rEtocS2cFWZ6dYxvHyFQRVV/4pj7d2AcO3MyNFUvPEwxAOgzT0Q43P0a4tRk7X9/pH5Mzk/9hWrKxxh4YeQ2u7OqReQHvTrIcDJJlk9bs=
Message-ID: <465e1cd3050705091374315f62@mail.gmail.com>
Date: Tue, 5 Jul 2005 18:13:04 +0200
From: davide vecchio <davide.vecchio@gmail.com>
Reply-To: davide vecchio <davide.vecchio@gmail.com>
To: Russell Miller <rmiller@duskglow.com>
Subject: Re: Problem with PS/2 Logitech WheelMouse
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200507050905.51865.rmiller@duskglow.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <465e1cd305070508442be8af@mail.gmail.com>
	 <200507050905.51865.rmiller@duskglow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry Russel,
what kind of patches ? As I was trying to explain I've tried 2 diffent
distros with many different kernel versions (2.6.11-4, 2.6.11-7 and
2.6.12) and on all the combinations the mouse doesn't work. did you
have a look at the dmesg snapshot?
What about that? are the boot messages correct?
Thanks in advance,
regards,
 Davide

On 7/5/05, Russell Miller <rmiller@duskglow.com> wrote:
> On Tuesday 05 July 2005 08:44, you wrote:
> 
> > Could you please give me any indication on what to try for ?
> >
> > Best regards,
> >  Davide
> >
> > PS: hoping this help I've attached the dmesg log for my last kernel
> > 2.6.12 rebuild and boot. Hope this help
> 
> Have you tried applying some of the patches that the distro kernels have
> applied and seeing if they fix the problem?
> 
> --Russell
>
