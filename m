Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262062AbUFNIkt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbUFNIkt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 04:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262208AbUFNIks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 04:40:48 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:48101 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S262062AbUFNIkr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 04:40:47 -0400
In-Reply-To: <20040611151918.00f47792.akpm@osdl.org>
Subject: Re: [PATCH] s390: speedup strn{cpy,len}_from_user.
To: Andrew Morton <akpm@osdl.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Build V651_12042003 December 04, 2003
Message-ID: <OFEA85E0DD.9DE87B05-ON42256EB3.002D6DAC-42256EB3.002FB01D@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Mon, 14 Jun 2004 10:40:52 +0200
X-MIMETrack: Serialize by Router on D12ML062/12/M/IBM(Release 6.0.2CF2HF259 | March 11, 2004) at
 14/06/2004 10:40:32
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





> There were a few conflicts with Arnd's sparse annotation, which I fixed
up.
> Please check that next the -mm has it all right.

Sorry. Arnd and I need to come up with a way to avoid conflicts in the future.

blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com


