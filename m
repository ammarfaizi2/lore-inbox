Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262750AbUDPIhF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 04:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262772AbUDPIhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 04:37:04 -0400
Received: from mail.dsa-ac.de ([62.112.80.99]:22794 "EHLO k2.dsa-ac.de")
	by vger.kernel.org with ESMTP id S262750AbUDPIhB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 04:37:01 -0400
Date: Fri, 16 Apr 2004 10:36:57 +0200 (CEST)
From: Guennadi Liakhovetski <gl@dsa-ac.de>
To: <linux-kernel@vger.kernel.org>
Subject: [OT] Capitals in kernel directory-names
Message-ID: <Pine.LNX.4.33.0404161029380.1869-100000@pcgl.dsa-ac.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-2.6.5$ find . -name "*[A-Z]*" -type d
./arch/m68knommu/platform/68360/uCquicc
./arch/m68knommu/platform/5407/MOTOROLA
./arch/m68knommu/platform/5407/CLEOPATRA
./arch/m68knommu/platform/68VZ328
./arch/m68knommu/platform/5282/MOTOROLA
./arch/m68knommu/platform/68EZ328
./arch/m68knommu/platform/5307/MP3
./arch/m68knommu/platform/5307/ARNEWSH
./arch/m68knommu/platform/5307/CLEOPATRA
./arch/m68knommu/platform/5307/NETtel
./arch/m68knommu/platform/5307/MOTOROLA
./arch/m68knommu/platform/5272/MOTOROLA
./arch/m68knommu/platform/5272/NETtel
./arch/m68knommu/platform/5206e/MOTOROLA
./arch/m68knommu/platform/5206e/eLITE
./arch/m68knommu/platform/5249/MOTOROLA
./arch/m68knommu/platform/5206/ARNEWSH
./arch/um/os-Linux
./include/asm-ppc64/iSeries
./Documentation
./Documentation/DocBook
./Documentation/arm/SA1100
./Documentation/arm/XScale
./Documentation/arm/XScale/IOP3XX
./Documentation/arm/XScale/ADIFCC
./Documentation/sound/alsa/DocBook
./Documentation/BK-usage

Which drives to a conclusion, that generally kernel-developers
(rightfully) dislike capital letters in file- and, even more so, in
directory-names. And the only directories named with capitals are some
arch-specifics, and Documentation. Well, was the latter named so to avoid
using the doc(umentation) pattern?:-)

Regards
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany

