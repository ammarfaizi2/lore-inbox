Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264054AbTFHXNh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 19:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264063AbTFHXNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 19:13:36 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:61275 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264059AbTFHXNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 19:13:31 -0400
Date: Sun, 8 Jun 2003 16:27:29 -0700
From: Andrew Morton <akpm@digeo.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.5.70-mm6: isp driver cleanups
Message-Id: <20030608162729.1b5f5ca5.akpm@digeo.com>
In-Reply-To: <20030608231750.GL16164@fs.tum.de>
References: <20030607151440.6982d8c6.akpm@digeo.com>
	<20030608231750.GL16164@fs.tum.de>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Jun 2003 23:27:08.0314 (UTC) FILETIME=[7AA217A0:01C32E15]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@fs.tum.de> wrote:
>
> isp_linux.h already states kernels < 2.4 are not supported. The patch 
>  below removes #ifdef'd code for kernels < 2.4.

I shall forward this along to Matthew, but there is not a lot of point in
working against the -mm version of this driver: it is just there for people
to test.

Thanks.
