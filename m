Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290551AbSBFOHq>; Wed, 6 Feb 2002 09:07:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290553AbSBFOHe>; Wed, 6 Feb 2002 09:07:34 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:60367 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S290551AbSBFOHO>; Wed, 6 Feb 2002 09:07:14 -0500
Date: Wed, 6 Feb 2002 15:06:18 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Hiroshi MIURA <miura@da-cha.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NSC Geode Companion chip workaround
In-Reply-To: <20020206022016.735C7118231@triton2>
Message-ID: <Pine.GSO.3.96.1020206150212.11725E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Feb 2002, Hiroshi MIURA wrote:

> I've tryed several month with this patch, It seems good for me.
>     trial machine: Casio CASSIOPEIA FIVA 101 and Fiva 103.
>                    MediaGX 200MHz and NSC Geode 300MHz.

 Does the chip fail with the readback 8254 command as well?  If not, it
would be a less intrusive change. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

