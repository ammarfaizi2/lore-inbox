Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265055AbUGIQh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265055AbUGIQh1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 12:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265074AbUGIQh0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 12:37:26 -0400
Received: from mproxy.gmail.com ([216.239.56.251]:61138 "HELO mproxy.gmail.com")
	by vger.kernel.org with SMTP id S265055AbUGIQhV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 12:37:21 -0400
Message-ID: <5ef8c2f004070909372db80ca8@mail.gmail.com>
Date: Fri, 9 Jul 2004 13:37:18 -0300
From: =?ISO-8859-1?Q?Jos=E9_de_Paula?= <espinafre@gmail.com>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: post 2.6.7 BK change breaks Java?
In-Reply-To: <40EEB1B2.7000800@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20040705231131.GA5958@merlin.emma.line.org> <Pine.LNX.4.56.0407091544170.22376@jjulnx.backbone.dif.dk> <40EEB1B2.7000800@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found that compiling 2.6.7-bk18 and 2.6.7-bk20 with  GCC 2.95 does
away with these random Java segmentation faults. Kernels compiled with
GCC 3.3, 3.2 and 3.0 on the same system, however, have this Java
problem. I hope this helps.
