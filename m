Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262303AbSJOD6T>; Mon, 14 Oct 2002 23:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262317AbSJOD6T>; Mon, 14 Oct 2002 23:58:19 -0400
Received: from [66.59.111.190] ([66.59.111.190]:26850 "EHLO
	sparrow.stearns.org") by vger.kernel.org with ESMTP
	id <S262303AbSJOD6T>; Mon, 14 Oct 2002 23:58:19 -0400
Date: Tue, 15 Oct 2002 00:04:01 -0400 (EDT)
From: William Stearns <wstearns@pobox.com>
X-X-Sender: wstearns@sparrow
Reply-To: William Stearns <wstearns@pobox.com>
To: ML-linux-kernel <linux-kernel@vger.kernel.org>
cc: William Stearns <wstearns@pobox.com>
Subject: 2.5.42 file permissions
Message-ID: <Pine.LNX.4.44.0210142328210.16989-100000@sparrow>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good day, all,
	In the stock 2.5.42 tree, the following files are mode 640, and 
should be mode 644:
-rw-r-----   17 root     root        17236 Sep 27 17:50 drivers/input/joystick/grip_mp.c
-rw-r-----   17 root     root         5910 Sep 27 17:49 include/video/neomagic.h
	Cheers,
	- Bill

---------------------------------------------------------------------------
	"Perfection is reached, not when there is no longer anything to
add, but when there is no longer anything to take away."
	-- Antoine de Saint-Exupery
(Courtesy of Thomas Graichen <tgr@spoiled.org>)
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, named2hosts, 
and ipfwadm2ipchains are at:                        http://www.stearns.org
--------------------------------------------------------------------------

