Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262100AbREQRje>; Thu, 17 May 2001 13:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262096AbREQRjY>; Thu, 17 May 2001 13:39:24 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:40466 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262092AbREQRjM>; Thu, 17 May 2001 13:39:12 -0400
Subject: Re: alpha/2.4.x: CPU misdetection, possible miscompilation
To: mike@rainbow.studorg.tuwien.ac.at (Michael Wildpaner)
Date: Thu, 17 May 2001 18:36:11 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0105171845310.2692-100000@rainbow.studorg.tuwien.ac.at> from "Michael Wildpaner" at May 17, 2001 07:00:43 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E150Rh5-0005mN-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Does gcc 2.96 or the gcc 3.0 snapshot also show this problem ?
> 
> 'gcc version 3.0 20010426' is fine.
> I don't have 2.96 at the moment, but can install if necessary.

No real need - the important thijng is that the gcc 3.0 compiler to be gets
it right.
