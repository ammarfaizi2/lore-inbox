Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290577AbSAYHR5>; Fri, 25 Jan 2002 02:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290576AbSAYHRk>; Fri, 25 Jan 2002 02:17:40 -0500
Received: from svr3.applink.net ([206.50.88.3]:63246 "EHLO svr3.applink.net")
	by vger.kernel.org with ESMTP id <S290548AbSAYHR0>;
	Fri, 25 Jan 2002 02:17:26 -0500
Message-Id: <200201250713.g0P7CJL09760@home.ashavan.org.>
Content-Type: text/plain; charset=US-ASCII
From: Timothy Covell <timothy.covell@ashavan.org>
Reply-To: timothy.covell@ashavan.org
To: brendan.simon@bigpond.com, linux-kernel@vger.kernel.org
Subject: Re: Linux console at boot
Date: Sat, 26 Jan 2002 01:13:41 -0600
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <CHEKKPICCNOGICGMDODJKEPAGBAA.george@gator.com> <200201250550.g0P5o1L09511@home.ashavan.org.> <3C50F43D.90707@bigpond.com>
In-Reply-To: <3C50F43D.90707@bigpond.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 24 January 2002 23:59, Brendan J Simon wrote:
> Timothy Covell wrote:
> >On Thursday 24 January 2002 23:05, George Bonser wrote:
> >>Is there any way to stop the console scrolling during boot? My reason
> >>for this is I am trying to troubleshoot a boot problem with
> >>2.4.18-pre7 and I would like to give a more useful report than "it
> >>won't boot" but the screen outputs information every few seconds and I
> >>can't "freeze" the display so I can copy down the initial error(s).
> >>
> >>This is an Intel unit using the standard console (not serial console).
> >>pre7 will not boot but pre6 boots every time.
>
> Try <ctrl>s to stop the display scrolling and <ctrl>q to restart it.
>
> Regards,
> Brendan Simon.
>

If you are using test kernels, then you should be prepared to use
a serial console, IHMO.   (I use them often anyhow inasmuch as I
don't have big KVM switch and only one monitor)   

Also, if it gets to the init part and you're using redhat, you can 
interrupt the boot sequence (step-by-step mode) and then try to
page up.    

Just my two cents.

-- 
timothy.covell@ashavan.org.
