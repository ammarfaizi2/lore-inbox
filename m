Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293203AbSHRInw>; Sun, 18 Aug 2002 04:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311749AbSHRInw>; Sun, 18 Aug 2002 04:43:52 -0400
Received: from dsl-213-023-021-254.arcor-ip.net ([213.23.21.254]:60117 "EHLO
	starship") by vger.kernel.org with ESMTP id <S293203AbSHRInw>;
	Sun, 18 Aug 2002 04:43:52 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] New PC-Speaker driver
Date: Sun, 18 Aug 2002 10:49:58 +0200
X-Mailer: KMail [version 1.3.2]
Cc: vda@port.imtp.ilyichevsk.odessa.ua
References: <3D5A8C2C.9010700@yahoo.com> <200208151137.g7FBbNp20417@Port.imtp.ilyichevsk.odessa.ua> <3D5BBC06.D1BA147E@aitel.hist.no>
In-Reply-To: <3D5BBC06.D1BA147E@aitel.hist.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17gLl1-0002yD-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 15 August 2002 16:34, Helge Hafting wrote:
> The senseless cpu usage for something as simple as sound
> is worse.

Sound is simple?  Okaaaay....

I first coded this technique up on a 20 MHz 386, running with a 20 KHz 
interrupt.  My current machine is more than 1,000 times faster.

If you can spare the 3-5% cpu anyway, who cares?  And finally, nobody is
forcing anybody to configure this driver.

-- 
Daniel
