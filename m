Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262274AbSJ0FYI>; Sun, 27 Oct 2002 01:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262290AbSJ0FYH>; Sun, 27 Oct 2002 01:24:07 -0400
Received: from sccrmhc03.attbi.com ([204.127.202.63]:50315 "EHLO
	sccrmhc03.attbi.com") by vger.kernel.org with ESMTP
	id <S262274AbSJ0FYH>; Sun, 27 Oct 2002 01:24:07 -0400
Subject: 2.5.44-ac3 -- linux/intermezzo_lib.h: No such file or directory
From: Miles Lane <miles.lane@attbi.com>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 26 Oct 2002 22:30:20 -0700
Message-Id: <1035696621.1216.2.camel@bellybutton>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This was first reported by Adrian Bunk against 2.5.43:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103475344003315&w=2

In file included from fs/intermezzo/cache.c:42:
include/linux/intermezzo_fs.h:30:34: linux/intermezzo_lib.h: No such
file or directory
include/linux/intermezzo_fs.h:31:34: linux/intermezzo_idl.h: No such
file or directory

