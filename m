Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbRAEPbo>; Fri, 5 Jan 2001 10:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129523AbRAEPbe>; Fri, 5 Jan 2001 10:31:34 -0500
Received: from enterprise.cistron.net ([195.64.68.33]:9478 "EHLO
	enterprise.cistron.net") by vger.kernel.org with ESMTP
	id <S129267AbRAEPbZ>; Fri, 5 Jan 2001 10:31:25 -0500
From: wichert@cistron.nl (Wichert Akkerman)
Subject: Re: Announce: modutils 2.4.0 is available
Date: 5 Jan 2001 16:31:12 +0100
Organization: Cistron Internet Services
Message-ID: <934pc0$g8n$1@picard.cistron.nl>
In-Reply-To: <14993.978663552@kao2.melbourne.sgi.com> <Pine.LNX.4.04.10101051247090.24805-100000@hantana.pdn.ac.lk> <20010105113104.L888@arthur.ubicom.tudelft.nl>
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010105113104.L888@arthur.ubicom.tudelft.nl>,
Erik Mouw  <J.A.K.Mouw@ITS.TUDelft.NL> wrote:
>Install the "alien" package on your machine and you will be able to
>convert between rpm and deb.

Bad plan, considering packages rely on some infrastructure that
is not in the rpm (update-modules). I tend to be pretty quick
with making and uploading the deb anyway.

Having said that, I won't package 2.4.0 and will wait for 2.4.1
instead.

Wichert.

-- 
   ________________________________________________________________
 / Generally uninteresting signature - ignore at your convenience  \
| wichert@cistron.nl                  http://www.liacs.nl/~wichert/ |
| 1024D/2FA3BC2D 576E 100B 518D 2F16 36B0  2805 3CB8 9250 2FA3 BC2D |
-- 
   ________________________________________________________________
 / Generally uninteresting signature - ignore at your convenience  \
| wichert@cistron.nl                  http://www.liacs.nl/~wichert/ |
| 1024D/2FA3BC2D 576E 100B 518D 2F16 36B0  2805 3CB8 9250 2FA3 BC2D |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
