Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285972AbRLaA4Y>; Sun, 30 Dec 2001 19:56:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285927AbRLaA4Q>; Sun, 30 Dec 2001 19:56:16 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:37131 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285883AbRLaA4A>; Sun, 30 Dec 2001 19:56:00 -0500
Subject: Re: Why would a valid DVD show zero files on Linux?
To: bryce@obviously.com (Bryce Nesbitt)
Date: Mon, 31 Dec 2001 01:06:36 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C2FB545.BA4544D7@obviously.com> from "Bryce Nesbitt" at Dec 30, 2001 07:45:57 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16KquS-0003DP-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have a DVD ROM (It's DeLorme Topo USA), which works fine booted in Windows.
> Under Linux it mounts fine, but shows no files.  Everything looks normal, like
> it should just work.

Mount it as a DVD not a CD-ROM media (ie udf format not iso9660) at a guess
