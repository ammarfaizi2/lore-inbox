Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267038AbSLPSqC>; Mon, 16 Dec 2002 13:46:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267042AbSLPSqB>; Mon, 16 Dec 2002 13:46:01 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:55699 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267036AbSLPSqA>;
	Mon, 16 Dec 2002 13:46:00 -0500
Date: Mon, 16 Dec 2002 18:53:32 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Where is this printk?
Message-ID: <20021216185332.GH15256@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Marc-Christian Petersen <m.c.p@wolk-project.de>,
	linux-kernel@vger.kernel.org
References: <200212161938.28306.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212161938.28306.m.c.p@wolk-project.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2002 at 07:43:24PM +0100, Marc-Christian Petersen wrote:
 > Hi all,
 > 
 > does anyone know where this is printed out in kernel source?
 > 
 > Linux version 2.4.20 (root@codeman) (gcc version 2.95.4 20011002 (Debian 
 > prerelease)) #1 Mon Dec 16 16:54:44 CET 2002

init/main.c start_kernel();

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
