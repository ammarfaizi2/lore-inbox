Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262449AbSLML4A>; Fri, 13 Dec 2002 06:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262442AbSLML4A>; Fri, 13 Dec 2002 06:56:00 -0500
Received: from [195.39.17.254] ([195.39.17.254]:4100 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262449AbSLMLz6>;
	Fri, 13 Dec 2002 06:55:58 -0500
Date: Thu, 12 Dec 2002 20:46:44 +0100
From: Pavel Machek <pavel@ucw.cz>
To: vojtech@ucw.cz, kernel list <linux-kernel@vger.kernel.org>
Subject: key "stuck" after resume
Message-ID: <20021212194644.GA767@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Vojtech, would it be possible to clear "keyboard down" map during
resume? It is pretty unlikely to be valid at that point :-).
								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
