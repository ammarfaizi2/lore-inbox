Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268501AbTCAFJg>; Sat, 1 Mar 2003 00:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268502AbTCAFJg>; Sat, 1 Mar 2003 00:09:36 -0500
Received: from out006pub.verizon.net ([206.46.170.106]:30108 "EHLO
	out006.verizon.net") by vger.kernel.org with ESMTP
	id <S268501AbTCAFJf>; Sat, 1 Mar 2003 00:09:35 -0500
Date: Sat, 1 Mar 2003 00:19:51 -0500 (EST)
From: "Ray O'Connor" <Ray.OConnor@verizon.net>
To: linux-kernel@vger.kernel.org
Subject: 2.5.63 and 3ware 7810 IDE raid controller
Message-ID: <Pine.LNX.4.44.0303010007330.12711-100000@bertha>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Authentication-Info: Submitted using SMTP AUTH at out006.verizon.net from [151.200.242.18] at Fri, 28 Feb 2003 23:19:52 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've using a 3ware 7810 IDE raid controller without problems thru 2.5.50.

Using 2.5.63, I'm now seeing %CPU > 90 for 3dmd, which is 3ware's
monitoring daemon.  Other than CPU usage, things work normally.

Any clues as to why I'm seeing this?

Don't have the source for the 3dmd, which is released only as a binary.

Thanks,
Ray

-- 
  Ray O'Connor    <Ray.OConnor@verizon.net>


