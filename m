Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932241AbVILVEk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbVILVEk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 17:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932243AbVILVEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 17:04:40 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:62406 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932241AbVILVEj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 17:04:39 -0400
Date: Mon, 12 Sep 2005 14:04:12 -0700
From: Paul Jackson <pj@sgi.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: hpa@zytor.com, akpm@osdl.org, linux-kernel@vger.kernel.org, bunk@stusta.de
Subject: Re: [RFC][MEGAPATCH] Change __ASSEMBLY__ to __ASSEMBLER__ (defined
 by GCC from 2.95 to current CVS)
Message-Id: <20050912140412.7c7ab794.pj@sgi.com>
In-Reply-To: <67DD59DE-B7B3-43EC-A241-670ACD4C0322@mac.com>
References: <C670AD22-97CF-46AA-A527-965036D78667@mac.com>
	<20050903064124.GA31400@codepoet.org>
	<4319BEF5.2070000@zytor.com>
	<B9E70F6F-CC0A-4053-AB34-A90836431358@mac.com>
	<dfhs4u$1ld$1@terminus.zytor.com>
	<5A37B032-9BBD-4AEA-A9BF-D42AFF79BC86@mac.com>
	<9C47C740-86CF-48F1-8DB6-B547E5D098FF@mac.com>
	<97597F8E-DDCE-479F-AE8D-CC7DC75AB3C3@mac.com>
	<20050910014543.1be53260.akpm@osdl.org>
	<4FAE9F58-7153-4574-A2C3-A586C9C3CFF1@mac.com>
	<20050910150446.116dd261.akpm@osdl.org>
	<E352D8E3-771F-4A0D-9403-DBAA0C8CBB83@mac.com>
	<20050910174818.579bc287.akpm@osdl.org>
	<93E9C5F9-A083-4322-A580-236E2232CCC0@mac.com>
	<20050912010954.70ac90e2.pj@sgi.com>
	<43259C9E.1040300@zytor.com>
	<20050912084756.4fa2bd07.pj@sgi.com>
	<67DD59DE-B7B3-43EC-A241-670ACD4C0322@mac.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle wrote:
> it will result in much less
> duplication of effort and much cleaner code.

It is not a foregone conclusion that combining two jobs into
one is less effort - that depends on how well the two jobs
merge.

Your comments remind me a little bit of the reassurance that
one hear's from a CEO justifying big merger.

Sometimes there's enough synergy to pay for the merger, sometimes
not.  The devil is in the details.

The devil really is in the details.

Since there is nothing further I have to contribute to these
details, I will return to my regularly scheduled cpuset programming.

Take care.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
