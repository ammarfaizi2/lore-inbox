Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261996AbSJVBrC>; Mon, 21 Oct 2002 21:47:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262003AbSJVBrC>; Mon, 21 Oct 2002 21:47:02 -0400
Received: from nycsmtp2out.rdc-nyc.rr.com ([24.29.99.227]:4565 "EHLO
	nycsmtp2out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S261996AbSJVBrB>; Mon, 21 Oct 2002 21:47:01 -0400
Date: Mon, 21 Oct 2002 21:45:29 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@localhost.localdomain
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com
Subject: 2.5.44 : move files from drivers/media/* ?
Message-ID: <Pine.LNX.4.44.0210212136030.900-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  There are video and radio drivers within
drivers/media/video and drivers/media/radio respectively.

Shouldn't those drivers move from drivers/media/video to drivers/video ? 
and same with radio (either a new directory or within an existing 
directory). It just seems that the drivers/media/ directory is unneeded. 
Thoughts?

Regards,
Frank

