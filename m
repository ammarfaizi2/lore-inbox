Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262871AbREVW3U>; Tue, 22 May 2001 18:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262875AbREVW3A>; Tue, 22 May 2001 18:29:00 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:24325 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262872AbREVW25>; Tue, 22 May 2001 18:28:57 -0400
Subject: Re: Gameport analog joystick broken in 2.4.4-ac13
To: stephen.thomas@insignia.com (Stephen Thomas)
Date: Tue, 22 May 2001 23:26:20 +0100 (BST)
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org
In-Reply-To: <3B0ADD9D.5424DE7F@insignia.com> from "Stephen Thomas" at May 22, 2001 10:43:57 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E152Kbd-0002a1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have an analog joystick plugged into the gameport of a Soundblaster
> AWE64.  In 2.4.4-ac12 this was recognized and worked just fine.  Under
> ac13 the recognition is incomplete - it seems to identify that there
> is a NS558 gameport device present, but not that there is a joystick
> plugged into it (unless I'm completely misunderstanding the log
> messages).

No joystick changes in 12->13. Is the fail repeatable ?
