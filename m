Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130022AbQLTWiE>; Wed, 20 Dec 2000 17:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130144AbQLTWhy>; Wed, 20 Dec 2000 17:37:54 -0500
Received: from mail3.teleport.com ([192.108.254.31]:45002 "HELO
	mail3.teleport.com") by vger.kernel.org with SMTP
	id <S130022AbQLTWhu>; Wed, 20 Dec 2000 17:37:50 -0500
Message-ID: <3A412C8D.59DDD9F2@BitWagon.com>
Date: Wed, 20 Dec 2000 14:02:53 -0800
From: John Reiser <jreiser@BitWagon.com>
Organization: -
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.5-15 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: tighter compression for x86 kernels
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Beta release v1.11 of the UPX executable compressor http://upx.tsx.org
offers new, tighter re-compression of compressed Linux kernels for x86.
Additional space savings of about 15% have been seen using
"upx --best vmlinuz" (example: 617431 ==> 525099, saving 92332 bytes).
Both source (GPLv2) and pre-compiled binary for x86 are available.
[I'm not subscribed to this mailing list, so CC: or mail me if appropriate.]

-- 
John Reiser, jreiser@BitWagon.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
