Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282406AbRKXJJ5>; Sat, 24 Nov 2001 04:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282407AbRKXJJs>; Sat, 24 Nov 2001 04:09:48 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:10509 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S282406AbRKXJJj>;
	Sat, 24 Nov 2001 04:09:39 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200111240908.fAO98nn454603@saturn.cs.uml.edu>
Subject: Re: Filesize limit on SMBFS
To: marcelo@datacom-telematica.com.br (Marcelo Borges Ribeiro)
Date: Sat, 24 Nov 2001 04:08:48 -0500 (EST)
Cc: birdty@uvsc.edu (Tyler BIRD), linux-kernel@vger.kernel.org,
        matti.aarnio@zmailer.org
In-Reply-To: <001501c1738b$2a4be5b0$1300a8c0@marcelo> from "Marcelo Borges Ribeiro" at Nov 22, 2001 05:23:13 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The ext2 and ext3 limits are the same. The kernel does not have
a 2 GB limit, though I'm sure most users believe it does.

Look at this graph:
http://www.cs.uml.edu/~acahalan/linux/ext2.gif

Pay attention to the note on the lower right.
