Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293445AbSCKBMF>; Sun, 10 Mar 2002 20:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293440AbSCKBLz>; Sun, 10 Mar 2002 20:11:55 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:4356 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293436AbSCKBLp>; Sun, 10 Mar 2002 20:11:45 -0500
Subject: Re: Anybody succesfully compiled a CD-R capable 2.4.x kernel?
To: maxvaldez@yahoo.com (Max Valdez)
Date: Mon, 11 Mar 2002 01:27:21 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C8BE68B.4619BA83@yahoo.com> from "Max Valdez" at Mar 10, 2002 05:04:43 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16kEav-0007lj-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Has anybody tried to compile a 2.4.x with cd burning  capabilities?, I

Yes it works fine

> I don't know if I'm missing some label on make config, i set scssi
> emulation, even the cd-r 82** module for the cd burner, and of course
> USB needed flags too.

USB burners need USB mass storage driver support
