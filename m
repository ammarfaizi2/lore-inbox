Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129581AbQLGFDH>; Thu, 7 Dec 2000 00:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129585AbQLGFC6>; Thu, 7 Dec 2000 00:02:58 -0500
Received: from 25-VALL-X7.libre.retevision.es ([62.83.213.25]:24960 "HELO
	lightside.2y.net") by vger.kernel.org with SMTP id <S129581AbQLGFCs>;
	Thu, 7 Dec 2000 00:02:48 -0500
Date: Thu, 7 Dec 2000 05:40:57 +0100
From: Ragnar Hojland Espinosa <ragnar_hojland@eresmas.com>
To: Mike Kravetz <mkravetz@sequent.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: test12pre6: BUG in schedule (sched.c, 115)
Message-ID: <20001207054057.A1657@lightside.2y.net>
In-Reply-To: <20001206195908.A190@lightside.2y.net> <20001206140012.B2215@w-mikek.des.sequent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 0.95.6i
In-Reply-To: <20001206140012.B2215@w-mikek.des.sequent.com>; from Mike Kravetz on Wed, Dec 06, 2000 at 02:00:12PM -0800
Organization: Mediocrity Naysayers Ltd
X-Homepage: http://maculaisdeadsoimmovingit/lightside
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2000 at 02:00:12PM -0800, Mike Kravetz wrote:
> Ragnar,
> 
> Are you sure that was line 115?  Could it have been line 515?

Yes, yes, it was 515.  115 is the result of human cache corruption ;)

> Also, do you have any Oops data?

It just froze there.

-- 
____/|  Ragnar Højland     Freedom - Linux - OpenGL      Fingerprint  94C4B
\ o.O|                                                   2F0D27DE025BE2302C
 =(_)=  "Thou shalt not follow the NULL pointer for      104B78C56 B72F0822
   U     chaos and madness await thee at its end."       hkp://keys.pgp.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
