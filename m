Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262670AbSKIVHs>; Sat, 9 Nov 2002 16:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262679AbSKIVHs>; Sat, 9 Nov 2002 16:07:48 -0500
Received: from smtp.terra.es ([213.4.129.129]:55483 "EHLO tsmtp10.mail.isp")
	by vger.kernel.org with ESMTP id <S262670AbSKIVHs>;
	Sat, 9 Nov 2002 16:07:48 -0500
Date: Sat, 9 Nov 2002 22:12:06 +0100
From: Arador <diegocg@teleline.es>
To: Jens Axboe <axboe@suse.de>
Cc: conman@kolivas.net, akpm@digeo.com, linux-kernel@vger.kernel.org,
       marcelo@conectiva.com.br, andrea@suse.de
Subject: Re: [BENCHMARK] 2.4.{18,19{-ck9},20rc1{-aa1}} with contest
Message-Id: <20021109221206.72d46e49.diegocg@teleline.es>
In-Reply-To: <20021109135446.GA2551@suse.de>
References: <200211091300.32127.conman@kolivas.net>
	<200211091612.08718.conman@kolivas.net>
	<20021109112135.GB31134@suse.de>
	<200211100009.55844.conman@kolivas.net>
	<20021109135446.GA2551@suse.de>
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Nov 2002 14:54:46 +0100
Jens Axboe <axboe@suse.de> wrote:

> The default is 2048. How long does the io_load test take, or rather how

then, shouldn't the default be changed?. There's a big performance drop (/2)
(in that case of course)


Diego Calleja
