Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262369AbTEKFbA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 01:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263445AbTEKFbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 01:31:00 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:42916 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262369AbTEKFa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 01:30:59 -0400
Date: Sat, 10 May 2003 22:44:21 -0700
From: Andrew Morton <akpm@digeo.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bug on shutdown from 68-mm4
Message-Id: <20030510224421.3347ea78.akpm@digeo.com>
In-Reply-To: <8570000.1052623548@[10.10.2.4]>
References: <8570000.1052623548@[10.10.2.4]>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 May 2003 05:43:36.0366 (UTC) FILETIME=[442E8CE0:01C31780]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> Sorry if this is old news, haven't been paying attention for a week.
>  Bug on shutdown (just after it says "Power Down") from 68-mm4.
>  (the NUMA-Q).

Random guess: is it related to CONFIG_KEXEC?
