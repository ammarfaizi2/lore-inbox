Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316220AbSEQNrD>; Fri, 17 May 2002 09:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316221AbSEQNrC>; Fri, 17 May 2002 09:47:02 -0400
Received: from dc-mx04.cluster1.charter.net ([209.225.8.14]:32658 "EHLO
	dc-mx04.cluster1.charter.net") by vger.kernel.org with ESMTP
	id <S316220AbSEQNrC>; Fri, 17 May 2002 09:47:02 -0400
To: <bvermeul@devel.blackstar.nl>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Kernel PCMCIA/CardBus on a Tecra 8200
In-Reply-To: <Pine.LNX.4.33.0205162339200.26976-100000@devel.blackstar.nl>
From: Norman Walsh <ndw@nwalsh.com>
X-URL: http://nwalsh.com/
Date: Fri, 17 May 2002 09:46:55 -0400
Message-ID: <87hel6ga40.fsf@nwalsh.com>
User-Agent: Gnus/5.090007 (Oort Gnus v0.07) Emacs/21.1 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

/ <bvermeul@devel.blackstar.nl> was heard to say:
| I've seen these messages before. Check config.opts, and make sure it's 
| valid. When in doubt, reinstall pcmcia-cs from woody.
| That seemed to fix the problem I had.

Thank you! In an act of some desperation, I --removed, --purged, and
re --installed the pcmcia-cs package and those problems went away.

                                        Be seeing you,
                                          norm

-- 
Norman Walsh <ndw@nwalsh.com> | It'll cost you.
http://nwalsh.com/            | 
