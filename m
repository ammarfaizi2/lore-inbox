Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261285AbVFDWQu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261285AbVFDWQu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 18:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbVFDWQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 18:16:50 -0400
Received: from fire.osdl.org ([65.172.181.4]:59283 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261285AbVFDWQt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 18:16:49 -0400
Date: Sat, 4 Jun 2005 15:11:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12?
Message-Id: <20050604151120.46b51901.akpm@osdl.org>
In-Reply-To: <394120000.1117895039@[10.10.2.4]>
References: <42A0D88E.7070406@pobox.com>
	<20050603163843.1cf5045d.akpm@osdl.org>
	<394120000.1117895039@[10.10.2.4]>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@mbligh.org> wrote:
>
> The one that worries me is that my x86_64 box won't boot since -rc3
>  See:
> 
>  http://ftp.kernel.org/pub/linux/kernel/people/mbligh/abat/regression_matrix.html

All the MPT_FUSION config variables got renamed, so a simple `make
oldconfig' results in a kernel qhich does precisely what your machine is
doing there.


