Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbTKXWmK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 17:42:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbTKXWmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 17:42:10 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:4551 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261376AbTKXWmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 17:42:08 -0500
Date: Mon, 24 Nov 2003 17:40:52 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Remi Colinet <remi.colinet@wanadoo.fr>
cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test9-mm5 : compile error
In-Reply-To: <3FBF99E6.1070402@wanadoo.fr>
Message-ID: <Pine.LNX.4.58.0311241740160.8180@montezuma.fsmlabs.com>
References: <3FBF5C79.5050409@wanadoo.fr> <Pine.LNX.4.53.0311220946280.2498@montezuma.fsmlabs.com>
 <3FBF99E6.1070402@wanadoo.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Nov 2003, Remi Colinet wrote:

> #include <asm/tlbflush.h>
> #include <asm/cpu.h>
>
> My original processs.c file seems to be a little be bit different from
> yours (?).
> The following line was already in the process.c file.
>
> +#include <asm/atomic_kmap.h>

Yes i appear to have botched my local -mm5 tree.

Thanks for testing it,
	Zwane
