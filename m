Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261994AbSJDU2f>; Fri, 4 Oct 2002 16:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261998AbSJDU2d>; Fri, 4 Oct 2002 16:28:33 -0400
Received: from paloma12.e0k.nbg-hannover.de ([62.181.130.12]:53464 "HELO
	paloma12.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S261994AbSJDU23> convert rfc822-to-8bit; Fri, 4 Oct 2002 16:28:29 -0400
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.40+: Sensors patch anyone? I think it is time for inclusion.
Date: Fri, 4 Oct 2002 22:33:55 +0200
User-Agent: KMail/1.4.7
Cc: Josh McKinney <forming@charter.net>, Jan Dittmer <jan@jandittmer.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200210042233.55796.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 4. Oktober 2002 18:52 schrieb Josh McKinney:
>On approximately Fri, Oct 04, 2002 at 07:30:15PM +0200, Jan Dittmer wrote:
> > 
> > Works without any problems. Patches for 2.5.33 from their website apply 
> > cleanly on 2.5.40.
> >
>
> I found the patches, although the link from the site doesn't work.
> "albert.html" doesn't exist anymore.  Do you know what all these patches
> are/or which ones did you apply to get it working?
>
> http://personal.atl.bellsouth.net/a/c/ac9410/albert/patches/
>
> Thursday, September 05, 2002  1:23 AM       193318 2.5.33-i2c_sensors.tar.gz

Unified tar all below included.

> Thursday, September 05, 2002  1:23 AM         1904 2.5.33-i2c-2-patch

Do not apply (because it is still in 2.5.40).

> Thursday, September 05, 2002  1:23 AM        42919 2.5.33-i2c-3a-patch
> Thursday, September 05, 2002  1:23 AM         8132 2.5.33-sensors-1-patch
> Thursday, September 05, 2002  1:23 AM       192772 2.5.33-sensors-2-patch
> Thursday, September 05, 2002  1:24 AM       817952 2.5.33-sensors-3-patch
> Thursday, September 05, 2002  1:24 AM        27413 2.5.33-sensors-4-patch
> Thursday, September 05, 2002  1:24 AM        17139 2.5.33-sensors-5-patch
> Thursday, September 05, 2002  1:24 AM          863 2.5.33-sensors-6-patch

Apply all in order on top of 2.5.40/2.5.40-acX/2.5.40-mcpX...

Regards,
	Dieter

-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel at hamburg.de (replace at with @)

