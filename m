Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266274AbSKUMv4>; Thu, 21 Nov 2002 07:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266609AbSKUMv4>; Thu, 21 Nov 2002 07:51:56 -0500
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:23790 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S266274AbSKUMvv>; Thu, 21 Nov 2002 07:51:51 -0500
Subject: Re: spinlocks, the GPL, and binary-only modules
From: Arjan van de Ven <arjanv@redhat.com>
To: David McIlwraith <quack@bigpond.net.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <024101c2903f$7650a050$41368490@archaic>
References: <Pine.LNX.4.44L.0211192349460.4103-100000@imladris.surriel.com>
	 <024101c2903f$7650a050$41368490@archaic>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Nov 2002 11:36:45 +0100
Message-Id: <1037875005.1863.0.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-20 at 03:49, David McIlwraith wrote:
> How should it? The compiler (specifically, the C preprocessor) includes the
> code, thus it is not the AUTHOR violating the GPL.

It is if the AUTHOR then decides to distribute the resulting binary
which would contain a mix of GPL and non GPL work..
