Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290571AbSAYFxF>; Fri, 25 Jan 2002 00:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290569AbSAYFwz>; Fri, 25 Jan 2002 00:52:55 -0500
Received: from svr3.applink.net ([206.50.88.3]:25870 "EHLO svr3.applink.net")
	by vger.kernel.org with ESMTP id <S290540AbSAYFwh>;
	Fri, 25 Jan 2002 00:52:37 -0500
Message-Id: <200201250550.g0P5o1L09511@home.ashavan.org.>
Content-Type: text/plain; charset=US-ASCII
From: Timothy Covell <timothy.covell@ashavan.org>
Reply-To: timothy.covell@ashavan.org
To: "George Bonser" <george@gator.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux console at boot
Date: Fri, 25 Jan 2002 23:51:25 -0600
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <CHEKKPICCNOGICGMDODJKEPAGBAA.george@gator.com>
In-Reply-To: <CHEKKPICCNOGICGMDODJKEPAGBAA.george@gator.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 24 January 2002 23:05, George Bonser wrote:
> Is there any way to stop the console scrolling during boot? My reason
> for this is I am trying to troubleshoot a boot problem with
> 2.4.18-pre7 and I would like to give a more useful report than "it
> won't boot" but the screen outputs information every few seconds and I
> can't "freeze" the display so I can copy down the initial error(s).
>
> This is an Intel unit using the standard console (not serial console).
> pre7 will not boot but pre6 boots every time.
>

you can get this info via "dmesg"

-- 
timothy.covell@ashavan.org.
