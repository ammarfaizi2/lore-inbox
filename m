Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276094AbRJ2QIL>; Mon, 29 Oct 2001 11:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276097AbRJ2QIB>; Mon, 29 Oct 2001 11:08:01 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:2976 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S276094AbRJ2QHw>; Mon, 29 Oct 2001 11:07:52 -0500
Date: Mon, 29 Oct 2001 17:07:51 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Alan Cox <laughing@shared-source.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.13-ac4
In-Reply-To: <20011028204003.A1640@lightning.swansea.linux.org.uk>
Message-ID: <Pine.GSO.3.96.1011029170323.3407F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Oct 2001, Alan Cox wrote:

> o	Handle chipsets that dont get 8254 latches	(Roberto Biancardi)
> 	right and trigger the VIA warning in error

 Hmm, has anyone tried using the "read back" 8254 command for latching,
instead?  Chances are it's less buggy... 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

