Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261937AbSI3Gln>; Mon, 30 Sep 2002 02:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261938AbSI3Gln>; Mon, 30 Sep 2002 02:41:43 -0400
Received: from enterprise.bidmc.harvard.edu ([134.174.118.50]:52234 "EHLO
	enterprise.bidmc.harvard.edu") by vger.kernel.org with ESMTP
	id <S261937AbSI3Gln> convert rfc822-to-8bit; Mon, 30 Sep 2002 02:41:43 -0400
Subject: Re: System very unstable
From: "Kristofer T. Karas" <ktk@enterprise.bidmc.harvard.edu>
To: Dieter =?ISO-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <200209290741.40679.Dieter.Nuetzel@hamburg.de>
References: <200209290741.40679.Dieter.Nuetzel@hamburg.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.7 
Date: 30 Sep 2002 02:47:04 -0400
Message-Id: <1033368426.779.4.camel@madmax>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-09-29 at 01:41, Dieter Nützel wrote:
> >        ktk@madmax:~$ glxgears 
> >        10797 frames in 5.0 seconds = 2159.400 FPS
> 
> This is slower than the current DRI can do ;-)
> 11955 frames in  5.000 seconds = 2391.000 FPS

Ah, well then!  :-)

The difference in numbers might be due to clock timing.  I have an
8500LEE, which was an original batch of 8500's that couldn't meet their
advertised clock times, so had the clock dropped back to 170MHz; they
were only sold that way in Japan, IIRC.  Driving it is a UP
AthlonXP-1700.  Running a 250MHz Radeon-8500 might surpass your numbers
(250/170 * 2159) = 3174!

Kris


