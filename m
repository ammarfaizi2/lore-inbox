Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310484AbSCBXzq>; Sat, 2 Mar 2002 18:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310485AbSCBXzg>; Sat, 2 Mar 2002 18:55:36 -0500
Received: from waste.org ([209.173.204.2]:44269 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S310484AbSCBXzV>;
	Sat, 2 Mar 2002 18:55:21 -0500
Date: Sat, 2 Mar 2002 17:55:10 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: vojtech@suse.cz
Subject: 2.5.5-dj2: psmouse.c: Lost synchronization
Message-ID: <Pine.LNX.4.44.0203021747070.14787-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seeing this with XFree 4.1 on my Thinkpad T22, either talking directly to
/dev/mice or through /dev/gpmdata. Results in the mouse jumping across the
screen and occassionally pulling up the root menu.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

