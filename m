Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130723AbQKANsb>; Wed, 1 Nov 2000 08:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130761AbQKANsV>; Wed, 1 Nov 2000 08:48:21 -0500
Received: from [212.115.175.146] ([212.115.175.146]:58874 "EHLO
	ftrs1.intranet.FTR.NL") by vger.kernel.org with ESMTP
	id <S130730AbQKANsM>; Wed, 1 Nov 2000 08:48:12 -0500
Message-ID: <27525795B28BD311B28D00500481B7601623A0@ftrs1.intranet.FTR.NL>
From: "Heusden, Folkert van" <f.v.heusden@ftr.nl>
To: "'Linux Kernel Development'" <linux-kernel@vger.kernel.org>
Subject: fork in module?
Date: Wed, 1 Nov 2000 14:51:38 +0100 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

what would be the way of starting a sub-process in a module which then would
run in the background? I guess plain fork() won't work?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
