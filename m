Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315887AbSENRJ2>; Tue, 14 May 2002 13:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315888AbSENRJ1>; Tue, 14 May 2002 13:09:27 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:8188 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S315887AbSENRJ0>; Tue, 14 May 2002 13:09:26 -0400
Subject: Re: SMP doc problem
From: Robert Love <rml@tech9.net>
To: blenderman@wanadoo.be
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200205141905.22856.blenderman@wanadoo.be>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 14 May 2002 10:09:19 -0700
Message-Id: <1021396159.823.59.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-05-14 at 10:05, Pol wrote:

> I think the file smp.txt in the kernel doc is bit outdated.
> I don't find the MAKE=make in the makefile.

Just add it.  Or do `MAKE="make -jN" make whatever"

	Robert Love

