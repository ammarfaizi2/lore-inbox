Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316775AbSHXVjA>; Sat, 24 Aug 2002 17:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316792AbSHXVjA>; Sat, 24 Aug 2002 17:39:00 -0400
Received: from admin.nni.com ([216.107.0.51]:59921 "EHLO admin.nni.com")
	by vger.kernel.org with ESMTP id <S316775AbSHXVi7>;
	Sat, 24 Aug 2002 17:38:59 -0400
Date: Sat, 24 Aug 2002 17:42:26 -0400
From: Andrew Rodland <arodland@noln.com>
To: Thunder from the hill <thunder@lightweight.ods.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] make localconfig
Message-Id: <20020824174226.28602dc2.arodland@noln.com>
In-Reply-To: <Pine.LNX.4.44.0208240759120.3234-100000@hawkeye.luckynet.adm>
References: <Pine.LNX.4.44.0208240759120.3234-100000@hawkeye.luckynet.adm>
X-Mailer: Sylpheed version 0.8.1claws38 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Aug 2002 08:12:46 -0600 (MDT)
Thunder from the hill <thunder@lightweight.ods.org> wrote:

> 	Generate a .config for the local computer, so that the kernel 
> 	could be built right in that moment. Therefor the local computer
> 	is being examined, probed and configured and all the devices
> 	that we find go into your .config.

It turns out that the autoconfigure script included in CML2 is actually
an adaptation of kautoconfigure (Giacomo Catenazzi <cate@debian.org>,
http://sf.net/projects/kautoconfigure), just tweaked to use CML2 and
python... a slightly older version that uses sh (well, bash) is still
available. The ruleset is something like 8 months old by now, but the
features provided are really pretty nifty. I used it once and it worked
very nicely. I don't know if it was the, erm, downfall of CML2 that
killed this project, but I wouldn't mind seeing it come back.
