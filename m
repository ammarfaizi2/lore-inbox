Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130766AbRBLA3C>; Sun, 11 Feb 2001 19:29:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130823AbRBLA2w>; Sun, 11 Feb 2001 19:28:52 -0500
Received: from adsl-64-123-56-71.dsl.stlsmo.swbell.net ([64.123.56.71]:1790
	"EHLO bigandy.swbell.net") by vger.kernel.org with ESMTP
	id <S130766AbRBLA2j>; Sun, 11 Feb 2001 19:28:39 -0500
Date: Sun, 11 Feb 2001 18:28:35 -0600 (CST)
From: Andy Carlson <naclos@swbell.net>
To: linux-kernel@vger.kernel.org
Subject: AMD PCNET under VMWare with kernel 2.4.2pre3 and 2.4.1-ac10
Message-ID: <Pine.LNX.4.20.0102111825570.13594-100000@bigandy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I installed a fresh Slackware 7.1 with kernel 2.2.16 to do some testing
with the 2.4 kernel series, all this under VMWare.  Everything was fine,
until I installed the new kernel (yes, I installed the stuff required in
the CHANGES file).  I cannot get 2.4.2pre3 or 2.4.1-ac10 to recognize
the AMD PCNET adapter.  Anyone having similar problems?

Andy Carlson                           |\      _,,,---,,_
naclos@swbell.net                ZZZzz /,`.-'`'    -.  ;-;;,_
BJC Health System                     |,4-  ) )-,_. ,\ (  `'-'
St. Louis, Missouri                  '---''(_/--'  `-'\_)
Cat Pics: http://andyc.dyndns.org

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
