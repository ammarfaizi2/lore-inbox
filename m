Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269118AbRHBUdC>; Thu, 2 Aug 2001 16:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269135AbRHBUcn>; Thu, 2 Aug 2001 16:32:43 -0400
Received: from pc1-cwbl2-0-cust80.cdf.cable.ntl.com ([62.252.63.80]:65518 "EHLO
	bagpuss.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S269118AbRHBUca>; Thu, 2 Aug 2001 16:32:30 -0400
From: Alan Cox <alan@bagpuss.swansea.linux.org.uk>
Message-Id: <200107292038.f6TKcYm01450@bagpuss.swansea.linux.org.uk>
Subject: Re: CLNP'
To: estevao@cyclades.com.br
Date: Sun, 29 Jul 2001 16:38:33 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <3B66FD74.B7F17B54@cyclades.com> from "Estevao A. Andrade" at Jul 31, 2001 03:48:20 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm looking for an implementation of CLNP (Connectionless Network
> Protocol). It is related to the network layer in the OSI model
> (equivalent to IP layer).

More efficient is to remove any existing uses of it

> My first idea is to grab all contributions, understand its complexity,
> and propose a feasible implementation.
> The related standards are ISO 10589, 8473, 9542.
> Any comments will be very appreciated.

Get a copy of ISODE, read and weep. Now guess why IP won

