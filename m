Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262170AbUFNJTR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262170AbUFNJTR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 05:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbUFNJTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 05:19:17 -0400
Received: from holomorphy.com ([207.189.100.168]:21151 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262170AbUFNJTQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 05:19:16 -0400
Date: Mon, 14 Jun 2004 02:19:13 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc3-mm2
Message-ID: <20040614091913.GY1444@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040614021018.789265c4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040614021018.789265c4.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2004 at 02:10:18AM -0700, Andrew Morton wrote:
> +ignore-errors-from-tw_setfeature-in-3w-xxxxc.patch
>  3ware driver fix

I've been informed this is bogus (I myself don't understand what's going
on with this patch).


On Mon, Jun 14, 2004 at 02:10:18AM -0700, Andrew Morton wrote:
> +fake-inquiry-for-sony-clie-peg-tj25-in-unusual_devsh.patch
>  Sony Clie USB driver fix

This unfortunately creates a duplicate entry in the unusual_devs.h

On Mon, Jun 14, 2004 at 02:10:18AM -0700, Andrew Morton wrote:
> +fix-thread_infoh-ignoring-__have_thread_functions.patch
>  m68k build fix

It's been suggested that the m68k people were withholding this in order
to come up with a better fix.


-- wli
