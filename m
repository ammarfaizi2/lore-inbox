Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275070AbRIYQfy>; Tue, 25 Sep 2001 12:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275082AbRIYQfe>; Tue, 25 Sep 2001 12:35:34 -0400
Received: from mta7.srv.hcvlny.cv.net ([167.206.5.22]:6852 "EHLO
	mta7.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S275070AbRIYQf0>; Tue, 25 Sep 2001 12:35:26 -0400
Date: Tue, 25 Sep 2001 12:47:44 -0400
From: John Check <j4strngs@rockfish.net>
Subject: Analog joystick fails on 2.4.10
To: linux-kernel@vger.kernel.org
Reply-to: j4strngs@rockfish.net
Message-id: <0GK8005FT8RYSX@mta7.srv.hcvlny.cv.net>
MIME-version: 1.0
X-Mailer: KMail [version 1.3.1]
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using the analog joystick driver through the gameport of an SB-Live
I had previously used the ns558 gameport driver with kernels up to and 
including 2.4.9 with no problems. Using the emu10k1-gp module leaves me
with working buttons but dead axes. This is with a Gravis Blackhawk 4 button 
3 axis stick. I am loading the modules the same as always s/ns558/emu10k1-gp/
Reporting this as a bug. I'n not subscribed to list so if I'm missing 
something cc me. I'll monitor the list archives otherwise
Thanx
John

PS. 2.4.10 runs much better VM wise, I'm not eating swap like I was before.
FWIW I'm using reiserfs.
