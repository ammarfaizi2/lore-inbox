Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132914AbRDUUpT>; Sat, 21 Apr 2001 16:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132919AbRDUUpJ>; Sat, 21 Apr 2001 16:45:09 -0400
Received: from pc57-cam4.cable.ntl.com ([62.253.135.57]:22402 "EHLO
	kings-cross.london.uk.eu.org") by vger.kernel.org with ESMTP
	id <S132914AbRDUUow>; Sat, 21 Apr 2001 16:44:52 -0400
X-Mailer: exmh version 2.3.1 01/18/2001 (debian 2.3.1-1) with nmh-1.0.4+dev
To: Russell King <rmk@arm.linux.org.uk>
cc: Jochen Striepe <jochen@tolot.escape.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.4-pre6 does not compile 
In-Reply-To: Message from Russell King <rmk@arm.linux.org.uk> 
   of "Sat, 21 Apr 2001 21:34:30 BST." <20010421213430.D7576@flint.arm.linux.org.uk> 
In-Reply-To: <20010421221728.C4077@tolot.escape.de>  <20010421213430.D7576@flint.arm.linux.org.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 21 Apr 2001 21:44:41 +0100
From: Philip Blundell <philb@gnu.org>
Message-Id: <E14r4FF-000105-00@kings-cross.london.uk.eu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Its because you're using a version of gcc which doesn't have
>__builtin_expect (eg, egcs 1.1.2, some versions of gcc 2.95).

No 2.95.x has __builtin_expect.  There might be some 2.95-derived GNUpro that 
supports it but I doubt anyone is using those to build kernels.

p.


