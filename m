Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318742AbSHAMPx>; Thu, 1 Aug 2002 08:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318726AbSHAMOw>; Thu, 1 Aug 2002 08:14:52 -0400
Received: from [195.39.17.254] ([195.39.17.254]:14976 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S318729AbSHAMFR>;
	Thu, 1 Aug 2002 08:05:17 -0400
Date: Thu, 1 Aug 2002 12:24:08 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: 2.5.29 vesafb: repainting problems
Message-ID: <20020801102407.GA428@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

In 2.5.29, something changed with cursor. It now honours palette
setting; I liked previous behaviour more.

There are bad problems with repainting. Fire text editor (emacs), type
few words, move cursor few words back at the first letter of the word,
and start typing. I can get corruption of next letter within 20
keystrokes.
								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
