Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129361AbRBCJTq>; Sat, 3 Feb 2001 04:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129163AbRBCJT0>; Sat, 3 Feb 2001 04:19:26 -0500
Received: from jalon.able.es ([212.97.163.2]:33762 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129185AbRBCJTE>;
	Sat, 3 Feb 2001 04:19:04 -0500
Date: Sat, 3 Feb 2001 10:18:56 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Paul Jakma <paul@clubi.ie>
Cc: Jakub Jelinek <jakub@redhat.com>, "J . A . Magallon" <jamagallon@able.es>,
        Hans Reiser <reiser@namesys.com>, Alan Cox <alan@redhat.com>,
        Chris Mason <mason@suse.com>, Jan Kasprzak <kas@informatics.muni.cz>,
        linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
        "Yury Yu . Rupasov" <yura@yura.polnet.botik.ru>
Subject: Re: [reiserfs-list] Re: ReiserFS Oops (2.4.1, deterministic, symlink
Message-ID: <20010203101856.A1766@werewolf.able.es>
In-Reply-To: <20010202191701.Y16592@devserv.devel.redhat.com> <Pine.LNX.4.31.0102030420031.20193-100000@fogarty.jakma.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.31.0102030420031.20193-100000@fogarty.jakma.org>; from paul@clubi.ie on Sat, Feb 03, 2001 at 05:25:20 +0100
X-Mailer: Balsa 1.1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 02.03 Paul Jakma wrote:
> 
> didn't barf here with 2.96-70.
>

Does not barf nor 1 nor 0. Check return core (ie, echo $?).


-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.1-ac1 #2 SMP Fri Feb 2 00:19:04 CET 2001 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
