Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290289AbSEXUsw>; Fri, 24 May 2002 16:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312590AbSEXUr6>; Fri, 24 May 2002 16:47:58 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:15744 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S315119AbSEXUrs>; Fri, 24 May 2002 16:47:48 -0400
Date: Fri, 24 May 2002 14:47:49 -0600
Message-Id: <200205242047.g4OKlnR01444@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19-pre8 breaks apm=power-off on Asus A7M266-D
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. I've found that 2.4.19-pre8 (actually Marcelo's current
tree) breaks apm=power-off on a dual-Athalon Asus A7M266-D. I get
either an Oops or a silent hang during APM setup.

2.4.19-pre6 did not have this problem.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
