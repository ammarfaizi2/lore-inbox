Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262861AbSJAWVn>; Tue, 1 Oct 2002 18:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262862AbSJAWUP>; Tue, 1 Oct 2002 18:20:15 -0400
Received: from [195.39.17.254] ([195.39.17.254]:9988 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262861AbSJAWSH>;
	Tue, 1 Oct 2002 18:18:07 -0400
Date: Mon, 30 Sep 2002 02:44:33 +0000
From: Pavel Machek <pavel@suse.cz>
To: Dominik Brodowski <linux@brodo.de>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
       cpufreq@www.linux.org.uk
Subject: Re: [2.5.39] (4/5) CPUfreq Documentation
Message-ID: <20020930024433.F35@toy.ucw.cz>
References: <20020928112559.F1217@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20020928112559.F1217@brodo.de>; from linux@brodo.de on Sat, Sep 28, 2002 at 11:25:59AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> +--
> +          minimum CPU frequency  -  maximum CPU frequency  -  policy
> +CPU  0       1200000 ( 75%)      -     1600000 (100%)      -  performance
> +--

Ugh, another interce that tries to look nice, this time with "-" as
separator.... Ugly, ugly. Whats wrong with one-value-per-file?!

								Pavel

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

