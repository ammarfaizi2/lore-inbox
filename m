Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284322AbRLPGWq>; Sun, 16 Dec 2001 01:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284369AbRLPGWg>; Sun, 16 Dec 2001 01:22:36 -0500
Received: from axon.amtp.cam.ac.uk ([131.111.16.133]:20966 "EHLO
	axon.amtp.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S284322AbRLPGWS>; Sun, 16 Dec 2001 01:22:18 -0500
To: linux-kernel@vger.kernel.org
Cc: J.S.Peatfield@damtp.cam.ac.uk
Subject: crypto api stuff
From: Jon Peatfield <J.S.Peatfield@damtp.cam.ac.uk>
Date: 16 Dec 2001 06:22:16 +0000
In-Reply-To: Joerg Pommnitz's message of "Tue, 11 Dec 2001 12:45:22 GMT"
Message-ID: <vxju1urit0n.fsf@redmires.amtp.cam.ac.uk>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Having spent some time trying to decide which version of the crypto
api patch is best to apply to recent 2.4.x kernels I wondered if any
serious thought had been given to including this in the standard
kernel tree for 2.5 (and maybe some future 2.4 perhaps if it proves
stable in 2.5)?

I for one would like to take an off-the-shelf standard kernel and use
loopback to mount an encrypted file-system.  Maybe then vendors would
start including this functionality.

[ I assume that the US laws on exporting crypto (which I seem to
remember got relaxed a while back) are no longer a significant
problem, or there wouldn't be things like openssl or openssh in common
distros. ]

-- 
Jon Peatfield,  DAMTP,  Computer Officer,   University of Cambridge
Telephone: +44 1223  3 37852    Mail: J.S.Peatfield@damtp.cam.ac.uk
