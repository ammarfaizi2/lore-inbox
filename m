Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263709AbRFDK0O>; Mon, 4 Jun 2001 06:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264183AbRFDK0E>; Mon, 4 Jun 2001 06:26:04 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:6319 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S263709AbRFDKZw>; Mon, 4 Jun 2001 06:25:52 -0400
Date: Mon, 4 Jun 2001 12:16:41 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Tom Vier <tmv5@home.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.5-ac6
In-Reply-To: <20010601222709.A566@zero>
Message-ID: <Pine.GSO.3.96.1010604112821.26759A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Jun 2001, Tom Vier wrote:

> > o	Fix mmap cornercase				(Maciej Rozycki)
> 
> when i try running osf/1 netscape on alpha, mmap of libXmu fails. works fine
> on -ac5.

 Can you get a strace of your failing netscape?

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

