Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272591AbRHaCmt>; Thu, 30 Aug 2001 22:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272592AbRHaCmj>; Thu, 30 Aug 2001 22:42:39 -0400
Received: from app79.hitnet.RWTH-Aachen.DE ([137.226.181.79]:12295 "EHLO
	anduin.hitnet.rwth-aachen.de") by vger.kernel.org with ESMTP
	id <S272591AbRHaCma>; Thu, 30 Aug 2001 22:42:30 -0400
Date: Fri, 31 Aug 2001 04:42:47 +0200
From: Jan Niehusmann <jan@gondor.com>
To: linux-kernel@vger.kernel.org
Subject: Athlon doesn't like Athlon optimisation?
Message-ID: <20010831044247.B811@gondor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a computer with a duron 600 which doesn't like current athlon
optimised kernels: It runs fairly well with an old 2.4.0-test7 kernel
(but I had some unexplained crashes during the last months),
but crashes after a few minutes after booting 2.4.9-ac3 or 2.4.7. 

If I don't build the kernels for athlon, but for i386 only, the 
system seems to be stable. (Not tested for more than 20 minutes, 
but definitely longer than the athlon optimised kernel was able to run)

Does anybody know these symptoms and has an idea what may be wrong?
Is it likely to be a broken CPU? 
The board is an A7V with the infamous via chipset, but I don't think
this looks like the typical via problems, does it?

Jan

-- 
OpenPGP-signierte bzw. -verschlüsselte Mail erwünscht
EMail-Key: 1024D/F12DA065 (=> Keyserver oder auf Anfrage)

