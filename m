Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316856AbSFDWFR>; Tue, 4 Jun 2002 18:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316860AbSFDWFQ>; Tue, 4 Jun 2002 18:05:16 -0400
Received: from boreas.isi.edu ([128.9.160.161]:16786 "EHLO boreas.isi.edu")
	by vger.kernel.org with ESMTP id <S316856AbSFDWFP>;
	Tue, 4 Jun 2002 18:05:15 -0400
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andrew Morton <akpm@zip.com.au>, Chris Mason <mason@suse.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 12/16] fix race between writeback and unlink 
In-Reply-To: Your message of "Tue, 04 Jun 2002 13:23:04 PDT."
             <Pine.LNX.4.44.0206041320280.29100-100000@home.transmeta.com> 
Date: Tue, 04 Jun 2002 15:05:03 -0700
Message-ID: <8692.1023228303@ISI.EDU>
From: Craig Milo Rogers <rogers@ISI.EDU>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Sure. However, I don't think it should come as any surprise to anybody
>that trying to write to two different points in the same file is a bad
>idea.

	Databases?

					Craig Milo Rogers
