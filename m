Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266105AbRF2Piu>; Fri, 29 Jun 2001 11:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266104AbRF2Pik>; Fri, 29 Jun 2001 11:38:40 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:6408 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265997AbRF2Pi3>; Fri, 29 Jun 2001 11:38:29 -0400
Subject: Re: Qlogic Fiber Channel
To: christophe.barbe@lineo.fr (=?ISO-8859-1?Q?christophe_barb=E9?=)
Date: Fri, 29 Jun 2001 16:38:21 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <20010629173631.A15608@pc8.lineo.fr> from "=?ISO-8859-1?Q?christophe_barb=E9?=" at Jun 29, 2001 05:36:31 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15G0Ld-0000Vo-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> manage to get a recent IP-enhanced firmware we could rewrite the missing =
> IP
> code. Half of the job is already done in the source of this driver.
> 
> I didn't manage to reach the good person from qlogic. Perhaps someone wou=
> ld
> have better results.

Well lets wait and see what qlogic have to say, but removing IP support in
the middle of a stable release is bad. And I still do not believe the
driver will be hard to fix, its relatively clean

