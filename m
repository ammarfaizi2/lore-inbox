Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262845AbRE0RgU>; Sun, 27 May 2001 13:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262843AbRE0RgJ>; Sun, 27 May 2001 13:36:09 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:3597 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262842AbRE0RgF>; Sun, 27 May 2001 13:36:05 -0400
Subject: Re: Linux 2.4.4-ac17
To: mikeg@wen-online.de (Mike Galbraith)
Date: Sun, 27 May 2001 18:32:30 +0100 (BST)
Cc: jaswinder.singh@3disystems.com (Jaswinder Singh),
        laughing@shared-source.org (Alan Cox),
        riel@conectiva.com.br (Rik van Riel),
        viro@math.psu.edu (Alexander Viro),
        linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <Pine.LNX.4.33.0105270950280.803-100000@mikeg.weiden.de> from "Mike Galbraith" at May 27, 2001 10:25:13 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1544P0-000299-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes.. seems the caches need some size limits.  ramfs will lock you in
> a heart beat if you hit oom. (i made a typo during iozone run.. oops:)

ramnfs has resource limits in -ac for a reason.
