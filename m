Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129258AbQKDQ7I>; Sat, 4 Nov 2000 11:59:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129313AbQKDQ66>; Sat, 4 Nov 2000 11:58:58 -0500
Received: from bobas.nowytarg.top.pl ([212.244.190.69]:41481 "EHLO
	bobas.nowytarg.top.pl") by vger.kernel.org with ESMTP
	id <S129258AbQKDQ6q>; Sat, 4 Nov 2000 11:58:46 -0500
Date: Sat, 4 Nov 2000 16:13:59 +0100
From: Daniel Podlejski <underley@underley.eu.org>
To: linux-kernel@vger.kernel.org
Subject: Serial port bug
Message-ID: <20001104161359.A13209@witch.underley.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-PGP-Fingerprint: 4D 72 53 F8 FE 8C 53 B9  66 AD F6 EA C9 17 CD 82
X-GPG-Fingerprint: 299F 1820 582B 283A 5F50  37D9 AA0B 6E10 03D4 EA5D
X-Homepage: http://www.underley.eu.org/
X-Cert: http://www.brainbench.com/transcript.jsp?pid=124954
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Serial driver in 2.4.0-testx seems to be a little broken.

Works fine with modem, mouse etc, but want works with
Casio digital camera - communication random hangs up
durning geting photos from camera.

It was tested on few computers with QV 780 and gphoto.

Evertything works fine with 2.2 kernel.

-- 
Daniel Podlejski <underley@underley.eu.org>
   ... I am immortal, I have inside me blood of kings,
   I have no rival, No man can bemy equal ...
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
