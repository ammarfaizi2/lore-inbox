Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136123AbREJM2t>; Thu, 10 May 2001 08:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136145AbREJM2j>; Thu, 10 May 2001 08:28:39 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:40207 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136123AbREJM2g>; Thu, 10 May 2001 08:28:36 -0400
Subject: Re: something like an oops
To: rbultje@ronald.bitfreak.net (Ronald Bultje)
Date: Thu, 10 May 2001 13:32:43 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010510103555.C27612@tux.bitfreak.net> from "Ronald Bultje" at May 10, 2001 10:35:55 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14xpcd-0004h1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The video editor uses zoran hardware to playback the video (using Serguei
> Miridonov's zoran driver, version 0.8, for a Miro/Pinnacle DC10+). The
> video editor closes 'nicely', i.e. it returns control to the terminal and
> gives the quit message. Directly after returning control to the terminal, X

You should probably report this to the Zoran driver folks.

Alan

