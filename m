Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268966AbTCASCe>; Sat, 1 Mar 2003 13:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268974AbTCASCe>; Sat, 1 Mar 2003 13:02:34 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:43784 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268966AbTCASCe>; Sat, 1 Mar 2003 13:02:34 -0500
Date: Sat, 1 Mar 2003 10:10:23 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Christoph Hellwig <hch@lst.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] die kdevname(), die!
In-Reply-To: <20030301190355.A1900@lst.de>
Message-ID: <Pine.LNX.4.44.0303011009510.16800-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I really think that replacing "kdevname()" with "__bdevname()" is a step 
in the wrong direction (or at least sideways).

		Linus

