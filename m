Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130153AbQLNJu7>; Thu, 14 Dec 2000 04:50:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130569AbQLNJuu>; Thu, 14 Dec 2000 04:50:50 -0500
Received: from madjfppp.jazztel.es ([212.106.236.135]:896 "HELO
	lightside.2y.net") by vger.kernel.org with SMTP id <S130153AbQLNJui>;
	Thu, 14 Dec 2000 04:50:38 -0500
Date: Wed, 13 Dec 2000 14:55:22 +0100
From: Ragnar Hojland Espinosa <ragnar@jazzfree.com>
To: "J . A . Magallon" <jamagallon@able.es>
Cc: Jussi Laako <jussi@jlaako.pp.fi>, Marc Mutz <Marc@Mutz.com>,
        linux-kernel@vger.kernel.org
Subject: Re: VM problem (2.4.0-test11)
Message-ID: <20001213145522.A118@lightside.2y.net>
In-Reply-To: <3A36A163.3F01277D@jlaako.pp.fi> <3A36ADB8.3CE36940@Mutz.com> <3A36B3E5.CF9FC31D@jlaako.pp.fi> <20001213004119.A779@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 0.95.6i
In-Reply-To: <20001213004119.A779@werewolf.able.es>; from J . A . Magallon on Wed, Dec 13, 2000 at 12:41:19AM +0100
Organization: Mediocrity Naysayers Ltd
X-Homepage: http://maculaisdeadsoimmovingit/lightside
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2000 at 12:41:19AM +0100, J . A . Magallon wrote:
> There are various patches-ways-to-do available, kernel gurus are still working
> on it...
> (leave always some 4% of mem for root, kill some process when mem is exhausted,
> which one to kill...)

which is a bad idea;  4% of 1GB is a waste, and 4% of 8mb is really pushing
it (that is, if we are speaking about root just doing cleanup stuff)

-- 
____/|  Ragnar Højland     Freedom - Linux - OpenGL      Fingerprint  94C4B
\ o.O|                                                   2F0D27DE025BE2302C
 =(_)=  "Thou shalt not follow the NULL pointer for      104B78C56 B72F0822
   U     chaos and madness await thee at its end."       hkp://keys.pgp.com

Handle via comment channels only.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
