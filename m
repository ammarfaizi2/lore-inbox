Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267541AbTAGWgM>; Tue, 7 Jan 2003 17:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267536AbTAGWgM>; Tue, 7 Jan 2003 17:36:12 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:58116 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267541AbTAGWgL>; Tue, 7 Jan 2003 17:36:11 -0500
Date: Tue, 7 Jan 2003 22:44:49 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: rotation.
Message-ID: <Pine.LNX.4.44.0301072240530.17129-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm about to implement rotation which is needed for devices like the ipaq. 
The question is do we flip the xres and yres values depending on the 
rotation or do we just alter the data that will be drawn to make the 
screen appear to rotate. How does hardware rotate view the x and y axis?
Are they rotated or does just the data get rotated? 

