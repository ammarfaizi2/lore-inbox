Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135925AbRAGHAk>; Sun, 7 Jan 2001 02:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135926AbRAGHAb>; Sun, 7 Jan 2001 02:00:31 -0500
Received: from rasmus.uib.no ([129.177.12.30]:59289 "EHLO rasmus.uib.no")
	by vger.kernel.org with ESMTP id <S135925AbRAGHAO>;
	Sun, 7 Jan 2001 02:00:14 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.2.18:  your CPUs had inconsistent variable MTRR setting
From: Haavard Lygre <hklygre@online.no>
Date: 07 Jan 2001 07:55:46 +0100
Message-ID: <m3lmsnvojx.fsf@frode.valhall.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (GTK)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


During boot of 2.2.18 I get the following messages:

mtrr: your CPUs had inconsistent variable MTRR settings
mtrr: probably your BIOS does not setup all CPUs

Is this something I should worry about?


This is an MSI 694D Pro AI mainboard, with dual P-III 800EB processors
and 320Mb RAM, stock 2.2.18 kernel.

More info available upon request.


-- 
Håvard Lygre, hklygre@online.no
Bergen IT-Teknikk ANS, Conrad Mohrsvei 11, 5068 Bergen
Tlf: 55 360773  Fax: 55 360774
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
