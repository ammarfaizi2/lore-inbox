Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267050AbTAUQFg>; Tue, 21 Jan 2003 11:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267070AbTAUQFg>; Tue, 21 Jan 2003 11:05:36 -0500
Received: from [66.70.28.20] ([66.70.28.20]:2822 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S267050AbTAUQFg>; Tue, 21 Jan 2003 11:05:36 -0500
Date: Tue, 21 Jan 2003 16:33:37 +0100
From: DervishD <raul@pleyades.net>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Changing argv[0] under Linux.
Message-ID: <20030121153337.GI49@DervishD>
References: <20030114191420.GA162@DervishD> <Pine.LNX.3.96.1030121091135.30318C-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.3.96.1030121091135.30318C-100000@gatekeeper.tmr.com>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The method used in INN is to make arg 1 some space. So

    Unfortunately, the process in this case is 'init', so we cannot
easily do this :((

> Some systems have setproctitle() but it doesn't appear to be posix.

    Linux doesn't have setproctitle(), AFAIK, and seems to belong to
NetBSD :??? What a pity, because will be a very clean solution :7

    Thanks a lot for answering :)
    Raúl
