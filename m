Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262415AbSLJQKD>; Tue, 10 Dec 2002 11:10:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262416AbSLJQKD>; Tue, 10 Dec 2002 11:10:03 -0500
Received: from ma-northadams1b-112.bur.adelphia.net ([24.52.166.112]:640 "EHLO
	ma-northadams1b-112.bur.adelphia.net") by vger.kernel.org with ESMTP
	id <S262415AbSLJQKC>; Tue, 10 Dec 2002 11:10:02 -0500
Date: Tue, 10 Dec 2002 11:18:35 -0500
From: Eric Buddington <eric@ma-northadams1b-112.bur.adelphia.net>
To: linux-kernel@vger.kernel.org
Subject: 2.5.51 won't boot with devfs enabled
Message-ID: <20021210111835.A92@ma-northadams1b-112.bur.adelphia.net>
Reply-To: ebuddington@wesleyan.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: ECS Labs
X-Eric-Conspiracy: there is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With 2.5.51 (gcc-3.2, Athlon, mostly modules, DEVFS=y, DEVFS_DEBUG=y),
boot panics with "VFS: Cannot open root device "hda1" or
03:01".

I had the same problem with 2.5.50, avoidable by disabling devfs entirely.

-Eric
