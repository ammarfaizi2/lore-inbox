Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315372AbSEGHIk>; Tue, 7 May 2002 03:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315374AbSEGHIj>; Tue, 7 May 2002 03:08:39 -0400
Received: from ns.tasking.nl ([195.193.207.2]:24583 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id <S315372AbSEGHIi>;
	Tue, 7 May 2002 03:08:38 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.5.13 hangs with endless hda: lost interrupt
X-Attribution: KB
Reply-To: kees.bakker@altium.nl (Kees Bakker)
From: Kees Bakker <rnews@altium.nl>
Date: 07 May 2002 09:06:16 +0200
Message-ID: <sielgoo2s7.fsf@koli.tasking.nl>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.6
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I boot 2.5.13 it hangs at startup with endless
    hda: lost interrupt
It seems to happen at the moment it wants to activate swap. At least,
that's what I see when I boot 2.5.7 and compare the boot messages.
(Note that I have to write those messages down, because nothing can be
logged on disk at that point.)

I am clueless what to do next.

      Kees
