Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264041AbTJ1RHI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 12:07:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264046AbTJ1RHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 12:07:07 -0500
Received: from gaia.cela.pl ([213.134.162.11]:63246 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S264041AbTJ1RHG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 12:07:06 -0500
Date: Tue, 28 Oct 2003 18:06:45 +0100 (CET)
From: Maciej Zenczykowski <maze@cela.pl>
To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: CPU-Test similar to Memtest?
In-Reply-To: <20031028160550.GA855@rdlg.net>
Message-ID: <Pine.LNX.4.44.0310281803460.7378-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On the heels of my system going nuts when I enabled Highmem I've played
> with the ram and starting to wonder if it might all be good and I might
> have a CPU just panic'ing for the fun of it.
> 
> I'm going to run MEMTEST today when I get home and get a chance to make
> a bootable CD but I'm wondering if there might be a "CPUTEST" or such
> utility anyone knows of that'll poke and prod a dual athalon real well
> and make sure I don't have a flaky cpu.

Try running mprime235 torture test.  Available from GIMPS
(google://mersenne) it's very computationally intensive and a real good
CPU, cache & memory burner (so good that even many so-called 'rock-stable'
systems fail).  However it does require a running linux (try an older 2.4
kernel).

Cheers,
MaZe.

