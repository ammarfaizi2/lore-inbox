Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263330AbTDCJVg>; Thu, 3 Apr 2003 04:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263331AbTDCJVg>; Thu, 3 Apr 2003 04:21:36 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:62215 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S263330AbTDCJVg>; Thu, 3 Apr 2003 04:21:36 -0500
Date: Thu, 3 Apr 2003 11:33:02 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: toshiba_fir and toshiba_old IRDA drivers broken on 4030cdt
Message-ID: <20030403093302.GA20486@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

In 2.4.X, I'm able to get  IrDA working on 4030cdt. In 2.5.66,,
toshiba_fir complains about interrupt test not passed at boot, and
then just does not work; toshiba_old woks enough to do discovery, but
ircomm communication is still not possible.
						Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
