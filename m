Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262859AbTLPVyQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 16:54:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262901AbTLPVyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 16:54:16 -0500
Received: from fw.osdl.org ([65.172.181.6]:9925 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262859AbTLPVyO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 16:54:14 -0500
Date: Tue, 16 Dec 2003 13:55:06 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  > 256 CPU cpumask build fix - const confusion
Message-Id: <20031216135506.354231d7.akpm@osdl.org>
In-Reply-To: <20031216125229.14871a4e.pj@sgi.com>
References: <20031216125229.14871a4e.pj@sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
> Could you please apply the following patch.  It is needed
> to build kernels with > 256 CPUs.

I already have, but the -mm flow has been sluggish lately.  I'll try to get
test11-mm1 out tonight.  It looks like it'll hit 300 patches :(

