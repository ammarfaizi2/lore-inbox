Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262449AbSKMUBW>; Wed, 13 Nov 2002 15:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262450AbSKMUBW>; Wed, 13 Nov 2002 15:01:22 -0500
Received: from kim.it.uu.se ([130.238.12.178]:14804 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S262449AbSKMUBU>;
	Wed, 13 Nov 2002 15:01:20 -0500
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15826.45348.975051.211350@kim.it.uu.se>
Date: Wed, 13 Nov 2002 21:08:04 +0100
To: "Jon Burgess" <Jon_Burgess@eur.3com.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Super I/O chip drivers?
In-Reply-To: <80256C70.0062D643.00@notesmta.eur.3com.com>
References: <80256C70.0062D643.00@notesmta.eur.3com.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Burgess writes:
 > 
 > 
 > > it doesn't support the IT8703-F chip I wanted to experiment with.
 > 
 > It might be worth taking a look at lssuperio, the source mentions ITE device
 > detection.
 > 
 > http://home.t-online.de/home/gunther.mayer/lssuperio/

Thanks -- that was exactly what I was looking for.

/Mikael
