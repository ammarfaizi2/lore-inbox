Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262576AbVCVJEU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262576AbVCVJEU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 04:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262579AbVCVJET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 04:04:19 -0500
Received: from 90.Red-213-97-199.pooles.rima-tde.net ([213.97.199.90]:15239
	"HELO fargo") by vger.kernel.org with SMTP id S262576AbVCVJEF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 04:04:05 -0500
Date: Tue, 22 Mar 2005 10:04:08 +0100
From: David =?utf-8?B?R8OzbWV6?= <david@pleyades.net>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Voodoo 3 2000 framebuffer problem
Message-ID: <20050322090407.GA9084@fargo>
Mail-Followup-To: Linux-kernel <linux-kernel@vger.kernel.org>
References: <20050322075116.GC55@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050322075116.GC55@DervishD>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ;),

On Mar 22 at 08:51:16, DervishD wrote:
>     Linux Kernel 2.4.29, in a do-it-yourself linux box, equipped with
> an AGP Voodoo 3 2000 card, tdfx framebuffer support. I boot in vga
> mode 0x0f05, with parameter 'video=tdfx:800x600-32@100' and I get
> (correctly) 100x37 character grid. All of that is correct. What is
> not correct is the characters attributes, namely the 'blink'
> attribute.

It happens too using the voodoo3 framebuffer driver in 2.6 kernels.
Specifically i'm using 2.6.10

regards,

-- 
David Gómez                                      Jabber ID: davidge@jabber.org
