Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129701AbRB0R4N>; Tue, 27 Feb 2001 12:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129706AbRB0R4D>; Tue, 27 Feb 2001 12:56:03 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:41999 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129701AbRB0Rzu>; Tue, 27 Feb 2001 12:55:50 -0500
Subject: Re: [PATCH] Core dumps for threads
To: ddugger@willie.n0ano.com (Don Dugger)
Date: Tue, 27 Feb 2001 17:57:43 +0000 (GMT)
Cc: torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <20010227102954.A26230@willie.n0ano.com> from "Don Dugger" at Feb 27, 2001 10:29:54 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14XoNd-0003tm-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Umm I misread that patch somewhat. I take that comment back. It does indeed
do what I intended.

Would the mm folks care to verify the patch..

