Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129870AbQKTXsz>; Mon, 20 Nov 2000 18:48:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129874AbQKTXsp>; Mon, 20 Nov 2000 18:48:45 -0500
Received: from enterprise.cistron.net ([195.64.68.33]:8976 "EHLO
	enterprise.cistron.net") by vger.kernel.org with ESMTP
	id <S129870AbQKTXsd>; Mon, 20 Nov 2000 18:48:33 -0500
From: wichert@cistron.nl (Wichert Akkerman)
Subject: Re: Bug in large files ext2 in 2.4.0-test11 ?
Date: 20 Nov 2000 23:59:39 +0100
Organization: Cistron Internet Services
Message-ID: <8vcacr$196$1@picard.cistron.nl>
In-Reply-To: <D69EF5976ED@vcnet.vc.cvut.cz> <20001120141641.Y619@visi.net>
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20001120141641.Y619@visi.net>,
Ben Collins  <bcollins@debian.org> wrote:
>work in our transition mechanisms. IOW, we don't have to just worry about
>1 architecture and 1 distribution, we have to make sure upgrades work,
>make sure things don't break, and ensure backward compatibility is retained
>for 5 architectures that have released already (new archs don't need a
>transisition obviously).

Euhm, we released 6 architectures (arm, alpha, i386, m68k, powerpc and sparc)

Wichert.

-- 
   ________________________________________________________________
 / Generally uninteresting signature - ignore at your convenience  \
| wichert@cistron.nl                  http://www.liacs.nl/~wichert/ |
| 1024D/2FA3BC2D 576E 100B 518D 2F16 36B0  2805 3CB8 9250 2FA3 BC2D |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
