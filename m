Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131139AbQKVBly>; Tue, 21 Nov 2000 20:41:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130989AbQKVBlg>; Tue, 21 Nov 2000 20:41:36 -0500
Received: from 89-VALL-X9.libre.retevision.es ([62.83.211.89]:40064 "EHLO
	looping.es") by vger.kernel.org with ESMTP id <S132071AbQKVBlU>;
	Tue, 21 Nov 2000 20:41:20 -0500
Date: Wed, 22 Nov 2000 02:08:09 +0100
From: Ragnar Hojland Espinosa <ragnar@jazzfree.com>
To: Eugene Crosser <crosser@average.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test11: "_isofs_bmap: block < 0"
Message-ID: <20001122020809.A9587@macula.net>
In-Reply-To: <8vd0cb$5a0$1@pccross.average.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 0.95.6i
In-Reply-To: <8vd0cb$5a0$1@pccross.average.org>; from Eugene Crosser on Tue, Nov 21, 2000 at 08:14:51AM +0300
Organization: Mediocrity Naysayers Ltd
X-Homepage: http://maculaisdeadsoimmovingit/lightside
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2000 at 08:14:51AM +0300, Eugene Crosser wrote:
> zero entries on the mounted CD, and each "ls" attempt causes this
> kernel message:
> 
> _isofs_bmap: block < 0

Same here, except that once showed

	_isofs_bmap: block >= EOF (1633681408, 4096)

-- 
____/|  Ragnar Højland     Freedom - Linux - OpenGL      Fingerprint  94C4B
\ o.O|                                                   2F0D27DE025BE2302C
 =(_)=  "Thou shalt not follow the NULL pointer for      104B78C56 B72F0822
   U     chaos and madness await thee at its end."       hkp://keys.pgp.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
