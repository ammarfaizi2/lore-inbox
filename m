Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317278AbSFLAgj>; Tue, 11 Jun 2002 20:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317279AbSFLAgi>; Tue, 11 Jun 2002 20:36:38 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:30339 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S317278AbSFLAgh>; Tue, 11 Jun 2002 20:36:37 -0400
Date: Tue, 11 Jun 2002 18:36:36 -0600
Message-Id: <200206120036.g5C0aaJ16354@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: apm=power-off broken in 2.4.19-pre10 on Asus A7M266-D
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. I've found that 2.4.19-pre10 breaks apm=power-off on a
dual-Athalon Asus A7M266-D. I get either an Oops or a silent hang
during APM setup.

2.4.19-pre6 did not have this problem. The problem also existed with
2.4.19-pre8. I reported it, but have seen no response.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
