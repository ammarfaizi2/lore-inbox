Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264981AbTLWHa0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 02:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264987AbTLWHaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 02:30:25 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:4788 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S264981AbTLWHaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 02:30:21 -0500
Date: Mon, 22 Dec 2003 23:30:14 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.6.0-mm1
Message-ID: <106620000.1072164613@[10.10.2.4]>
In-Reply-To: <20031222211131.70a963fb.akpm@osdl.org>
References: <20031222211131.70a963fb.akpm@osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These look new to me.

In file included from init/initramfs.c:393:
init/../lib/inflate.c: In function `gunzip':
init/../lib/inflate.c:1123: warning: value computed is not used
init/../lib/inflate.c:1124: warning: value computed is not used
init/../lib/inflate.c:1125: warning: value computed is not used
init/../lib/inflate.c:1126: warning: value computed is not used
In file included from arch/i386/boot/compressed/misc.c:129:
arch/i386/boot/compressed/../../../../lib/inflate.c: In function `gunzip':
arch/i386/boot/compressed/../../../../lib/inflate.c:1123: warning: value computed is not used
arch/i386/boot/compressed/../../../../lib/inflate.c:1124: warning: value computed is not used
arch/i386/boot/compressed/../../../../lib/inflate.c:1125: warning: value computed is not used
arch/i386/boot/compressed/../../../../lib/inflate.c:1126: warning: value computed is not used


M.

