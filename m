Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288051AbSBZOxi>; Tue, 26 Feb 2002 09:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284933AbSBZOx2>; Tue, 26 Feb 2002 09:53:28 -0500
Received: from mustard.heime.net ([194.234.65.222]:19859 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S288012AbSBZOxT>; Tue, 26 Feb 2002 09:53:19 -0500
Date: Tue, 26 Feb 2002 15:53:17 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: <linux-kernel@vger.kernel.org>
Subject: [BUG] Getting incorrect size on large files from DVD
Message-ID: <Pine.LNX.4.30.0202261551150.14140-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

Reading > 2^31bytes files, results in Linux reporting extremely low size -
typically <10MB. Putting the same DVD disc into a Windoze box works fine.

Anyone have any ideas?

I'm running 2.4.18-rc2

roy


--
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.

