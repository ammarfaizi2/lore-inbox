Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261822AbSJPLpg>; Wed, 16 Oct 2002 07:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262147AbSJPLpf>; Wed, 16 Oct 2002 07:45:35 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:34006 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S261822AbSJPLpf>; Wed, 16 Oct 2002 07:45:35 -0400
Date: Wed, 16 Oct 2002 13:51:54 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "David S. Miller" <davem@redhat.com>
cc: jw@pegasys.ws, linux-kernel@vger.kernel.org
Subject: Re: mapping 36 bit physical addresses into 32 bit virtual
In-Reply-To: <20021016.002408.78874810.davem@redhat.com>
Message-ID: <Pine.GSO.3.96.1021016134712.14774G-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Oct 2002, David S. Miller wrote:

>    i distinctly remember the working
>    with the newest R400x in 1993 which was still 32bit.
> 
> You remember wrong, R400x can run happily in either 32-bit or 64-bit
> mode.

 Many system implementations sticked to a 32-bit operation of R4k
processors, though, possibly because of a few intriguing processor errata
in early silicon revisions that hurt badly certain 64-bit operations. 
This might have created an illusion these processors were 32-bit. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

