Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265895AbTBPG1p>; Sun, 16 Feb 2003 01:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265898AbTBPG1p>; Sun, 16 Feb 2003 01:27:45 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:55053
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S265895AbTBPG1p>; Sun, 16 Feb 2003 01:27:45 -0500
Subject: Re: [PATCH] make jiffies wrap 5 min after boot
From: Robert Love <rml@tech9.net>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Anton Blanchard <anton@samba.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       lkml <linux-kernel@vger.kernel.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <20030216024317.GM29983@holomorphy.com>
References: <Pine.LNX.4.33L2.0302040935230.6174-100000@dragon.pdx.osdl.net>
	 <Pine.LNX.4.33.0302160232120.7975-100000@gans.physik3.uni-rostock.de>
	 <20030216020808.GF9833@krispykreme> <20030216024317.GM29983@holomorphy.com>
Content-Type: text/plain
Organization: 
Message-Id: <1045377459.2175.0.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.0.99 (Preview Release)
Date: 16 Feb 2003 01:37:40 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-02-15 at 21:43, William Lee Irwin III wrote:

> Can I get a vote for ~0UL instead of -1UL?

OK, I bite.  What is the difference?  Aren't both equivalent?

	Robert Love

