Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbUBHBPW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 20:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261799AbUBHBPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 20:15:22 -0500
Received: from fw.osdl.org ([65.172.181.6]:37036 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261784AbUBHBPS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 20:15:18 -0500
Date: Sat, 7 Feb 2004 17:17:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: jsimmons@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] pm3fb: remove kernel 2.2 code
Message-Id: <20040207171712.0e725f7e.akpm@osdl.org>
In-Reply-To: <20040208010609.GG7388@fs.tum.de>
References: <20040208010609.GG7388@fs.tum.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@fs.tum.de> wrote:
>
> The patch below removes kernel 2.2 code from pm3fb.{c,h}.

umm, exactly how many more patches like this were you planning on sending? 
If it's just a few then OK, but I'm afraid I don't really have the energy
for a huge round of 2.[024] decrufitfication patches right now.  Sorry.

