Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263141AbUDEGC2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 02:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263142AbUDEGC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 02:02:28 -0400
Received: from 201008050033.user.veloxzone.com.br ([201.8.50.33]:31941 "EHLO
	pervalidus.dyndns.org") by vger.kernel.org with ESMTP
	id S263141AbUDEGC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 02:02:27 -0400
Date: Mon, 5 Apr 2004 03:02:24 -0300 (BRT)
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <1@pervalidus.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-mc1
In-Reply-To: <20040404194037.09d67c37.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0404050300470.1706@pervalidus.dyndns.org>
References: <20040404194037.09d67c37.akpm@osdl.org>
X-Archive: encrypt
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch doesn't apply to 2.6.5 or 2.6.5-mm1. I get:

The next patch would create the file arch/alpha/kernel/osf_sys.c,
which already exists!  Assume -R? [n]

and so on.

2.6.5-mm1 applies cleanly.

On Sun, 4 Apr 2004, Andrew Morton wrote:

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5/2.6.5-mc1/

-- 
http://www.pervalidus.net/contact.html
