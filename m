Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287828AbSBKQcI>; Mon, 11 Feb 2002 11:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289820AbSBKQb6>; Mon, 11 Feb 2002 11:31:58 -0500
Received: from mx.fluke.com ([129.196.128.53]:1543 "EHLO evtvir03.tc.fluke.com")
	by vger.kernel.org with ESMTP id <S287828AbSBKQby>;
	Mon, 11 Feb 2002 11:31:54 -0500
Date: Mon, 11 Feb 2002 08:31:54 -0800 (PST)
From: David Dyck <dcd@tc.fluke.com>
To: <linux-kernel@vger.kernel.org>
Subject: more than one file matches LATEST-IS-* in /pub/linux/kernel/v2.5/
Message-ID: <Pine.LNX.4.33.0202110830460.10177-100000@dd.tc.fluke.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



ncftp /pub/linux/kernel/v2.5 > ls -l *LAT*
-rw-r--r--   1 korg     korg            0   Jan 30 19:19   LATEST-IS-2.5.3
-rw-r--r--   1 korg     korg            0   Feb 11 01:53   LATEST-IS-2.5.4


