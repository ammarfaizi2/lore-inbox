Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275211AbTHRWRc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 18:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275213AbTHRWRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 18:17:32 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:29447 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S275211AbTHRWRb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 18:17:31 -0400
Date: Tue, 19 Aug 2003 00:17:28 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Andries.Brouwer@cwi.nl, Dominik.Strasser@t-online.de, hch@infradead.org,
       jgarzik@pobox.com, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: headers
Message-ID: <20030819001728.A1211@pclin040.win.tue.nl>
References: <UTC200308181907.h7IJ7im12407.aeb@smtp.cwi.nl> <20030818145709.0b5e162a.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030818145709.0b5e162a.rddunlap@osdl.org>; from rddunlap@osdl.org on Mon, Aug 18, 2003 at 02:57:09PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 18, 2003 at 02:57:09PM -0700, Randy.Dunlap wrote:
> | In case people want to try just one file, do signal.h.
> 
> Since there are 20+ <arch>/signal.h files and they don't always agree
> on signal bit numbers e.g., do we have 20+ abi/arch/signal.h files?
> Or 1 abi/signal.h file with many #ifdefs?  ugh.
> 
> The ABI is still per-arch, right?  Not _one ABI_ for any/all arches.

Yes, per arch.

