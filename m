Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279509AbRJXK0C>; Wed, 24 Oct 2001 06:26:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279514AbRJXKZv>; Wed, 24 Oct 2001 06:25:51 -0400
Received: from maild.telia.com ([194.22.190.101]:3804 "EHLO maild.telia.com")
	by vger.kernel.org with ESMTP id <S279509AbRJXKZk>;
	Wed, 24 Oct 2001 06:25:40 -0400
Date: Thu, 25 Oct 2001 12:29:14 +0200
From: =?iso-8859-1?Q?Andr=E9?= Dahlqvist <andre.dahlqvist@telia.com>
To: linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.13..
Message-ID: <20011025122914.C7742@telia.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0110232249090.1185-100000@penguin.transmeta.com> <20011024215621.A28809@nicholas.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20011024215621.A28809@nicholas.net.nz>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Nicholas <cilix@lsd.net.nz> wrote:

> Every time i tried to do anything i got the same error....
> 
> Inconsistency detected by ld.so: dynamic-link.h: 62:
> elf_get_dynamic_info: Assertion `! "bad dynamic tag"' failed!

What compiler are you using, and what version of binutils? A recent
binutils in Debian was rather borked, so that might be the problem.
-- 

André Dahlqvist <andre.dahlqvist@telia.com>
