Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266182AbUAVJuS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 04:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266185AbUAVJuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 04:50:18 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:46827 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S266182AbUAVJuO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 04:50:14 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16399.40148.940301.462448@laputa.namesys.com>
Date: Thu, 22 Jan 2004 12:50:12 +0300
To: Bart Samwel <bart@samwel.tk>
Cc: Micha Feigin <michf@post.tau.ac.il>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] reiserfs support for laptop_mode
In-Reply-To: <400ED428.20301@samwel.tk>
References: <20040117061354.GB4768@luna.mooo.com>
	<16395.45959.836058.398889@laputa.namesys.com>
	<20040121182846.GB29494@luna.mooo.com>
	<400ED428.20301@samwel.tk>
X-Mailer: VM 7.17 under 21.5  (beta16) "celeriac" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bart Samwel writes:
 > 

[...]

 > A couple of comments:
 > 
 > * You might want to take a look at Hugang's patch to support laptop mode 
 > on reiserfs in 2.6. This patch was posted somewhere last month. It adds 
 > a "commit=" option to reiserfs, so that you can change this externally 
 > by remounting. I think this solution is a lot cleaner than to have 
 > reiserfs code directly depend on laptop mode.

This patch was merged into mainline.

 > 
 > 
 > -- Bart

Nikita.

