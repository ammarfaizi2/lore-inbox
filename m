Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266047AbRF1RbZ>; Thu, 28 Jun 2001 13:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266054AbRF1RbP>; Thu, 28 Jun 2001 13:31:15 -0400
Received: from polypc17.chem.rug.nl ([129.125.25.92]:30594 "EHLO
	polypc17.chem.rug.nl") by vger.kernel.org with ESMTP
	id <S266047AbRF1RbC>; Thu, 28 Jun 2001 13:31:02 -0400
Date: Thu, 28 Jun 2001 19:31:00 +0200 (CEST)
From: "J.R. de Jong" <jdejong@chem.rug.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.4.5 NFS io errors
Message-ID: <Pine.LNX.4.21.0106281918160.3048-100000@polypc17.chem.rug.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Recently I upgraded from 2.4.4 to 2.4.5, but after that I got users
complaining about io errors on some mounted NFS systems on some files,
whenever they tried to stat (ls) or open the file. Even after several
reboots (other files failed tho).

Going back to 2.4.4 solved the problem. I don't know if this problem has
been adressed already.

- Johan de Jong.


