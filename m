Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263599AbTKDCiC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 21:38:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263600AbTKDCiC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 21:38:02 -0500
Received: from modemcable137.219-201-24.mc.videotron.ca ([24.201.219.137]:34945
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S263599AbTKDCiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 21:38:00 -0500
Date: Mon, 3 Nov 2003 21:37:08 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Nick Piggin <piggin@cyberone.com.au>
cc: Jan Dittmer <j.dittmer@portrix.net>, linux-kernel@vger.kernel.org
Subject: Re: Clock skips (?) with 2.6 and games
In-Reply-To: <3FA62F18.2050500@cyberone.com.au>
Message-ID: <Pine.LNX.4.53.0311032136320.20595@montezuma.fsmlabs.com>
References: <3FA62DD4.1020202@portrix.net> <3FA62F18.2050500@cyberone.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Nov 2003, Nick Piggin wrote:

> nosmp has been broken for quite a while. If you want to try uniprocessor,
> you'd have to compile a UP kernel.

Hmm? It works here even with sparse APIC IDs.

