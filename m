Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266463AbUHPXkU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266463AbUHPXkU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 19:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266469AbUHPXkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 19:40:19 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:43423 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266463AbUHPXkE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 19:40:04 -0400
Date: Mon, 16 Aug 2004 16:39:30 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm1
Message-ID: <121120000.1092699569@flay>
In-Reply-To: <20040816143710.1cd0bd2c.akpm@osdl.org>
References: <20040816143710.1cd0bd2c.akpm@osdl.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8.1/2.6.8.1-mm1

make install from this config file:

ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/config/config.numaq

results in this failure:

make: *** No rule to make target `.tmp_kallsyms2.S', needed by `.tmp_kallsyms2.o'.  Stop.

gcc 2.95.4 ... 2.6.8.1 compiles fine. I have a feeling that people have discussed
this before - apologies if so, but I can't find the answer in my logs -sorry.


M.

