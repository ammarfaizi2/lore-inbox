Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267730AbRGRCFt>; Tue, 17 Jul 2001 22:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267743AbRGRCFj>; Tue, 17 Jul 2001 22:05:39 -0400
Received: from pizda.ninka.net ([216.101.162.242]:24704 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267730AbRGRCFa>;
	Tue, 17 Jul 2001 22:05:30 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15188.61164.315022.913819@pizda.ninka.net>
Date: Tue, 17 Jul 2001 19:05:32 -0700 (PDT)
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <dpicard@rcn.com>, <axboe@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: PATCH for Corrupted IO on all block devices
In-Reply-To: <Pine.LNX.4.33.0107171840550.1175-100000@penguin.transmeta.com>
In-Reply-To: <3B54E85E.6E917925@psind.com>
	<Pine.LNX.4.33.0107171840550.1175-100000@penguin.transmeta.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus Torvalds writes:
 > What filesystem do you see the bug with?

His report did specifically mention "databases".  But my initial
impression was the same as yours, that this is a bug in the user.

Later,
David S. Miller
davem@redhat.com
