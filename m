Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264936AbRFUMGs>; Thu, 21 Jun 2001 08:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264937AbRFUMGi>; Thu, 21 Jun 2001 08:06:38 -0400
Received: from [213.38.169.194] ([213.38.169.194]:19475 "EHLO
	proxy.herefordshire.gov.uk") by vger.kernel.org with ESMTP
	id <S264936AbRFUMGV> convert rfc822-to-8bit; Thu, 21 Jun 2001 08:06:21 -0400
Message-ID: <AFE36742FF57D411862500508BDE8DD00199504B@mail.herefordshire.gov.uk>
From: "Randal, Phil" <prandal@herefordshire.gov.uk>
To: linux-kernel@vger.kernel.org
Subject: RE: temperature standard - global config option?
Date: Thu, 21 Jun 2001 13:06:23 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Morton wrote:

> I should instead write 59 ±2°C, since that is the most precision
> I can possibly know it to.  With some advanced measuring techniques
> it *may* be acceptable to write 59.43 ±2°C *at most*, and then only
> if you really know why you need the extra information.

It's easy to conceive of a device which, for whatever reason, gives
an "absolute" reading accurate ±2°C, but which tracks temperature
changes somewhat more accurately.  And hence a small difference
between successive readings still has significance.  A real-world
example is a mercury thermometer in which the glass has been
physically shifted relative to an adjacent scale.  So 18°C reads as
20°C, etc.

Cheers,

Phil

---------------------------------------------
Phil Randal
Network Engineer
Herefordshire Council
Hereford, UK
