Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314607AbSDTMMj>; Sat, 20 Apr 2002 08:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314608AbSDTMMi>; Sat, 20 Apr 2002 08:12:38 -0400
Received: from [194.234.65.222] ([194.234.65.222]:11191 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S314607AbSDTMMi>; Sat, 20 Apr 2002 08:12:38 -0400
Date: Sat, 20 Apr 2002 14:12:34 +0200 (CEST)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
X-X-Sender: roy@mustard.heime.net
To: linux-kernel@vger.kernel.org
Subject: O_LARGEFILE support in smbfs?
Message-ID: <Pine.LNX.4.44.0204201411140.10869-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

I'm having problems accessing large files (>2GB) across a mounted share on 
a win2k server. Is this a known problem?

I'm running 2.4.18

roy

-- 
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.

