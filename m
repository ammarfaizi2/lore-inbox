Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264515AbTH2KpN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 06:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264532AbTH2KpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 06:45:13 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:28422 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S264515AbTH2KpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 06:45:11 -0400
Subject: Re: 2.6.0-test4: Hang in i8042_init
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3F4EDC47.2020302@cyberone.com.au>
References: <3F4EDC47.2020302@cyberone.com.au>
Content-Type: text/plain
Message-Id: <1062153908.700.4.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 29 Aug 2003 12:45:08 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-08-29 at 06:53, Nick Piggin wrote:
> Is what I am getting. Last line is something like input: PC Speaker
> (followed by the initcall).
> 
> dmseg and lspci from a working kernel attached. Let me know if I can
> do more.

Could it be something related with
http://bugzilla.kernel.org/show_bug.cgi?id=1123?

