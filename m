Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030326AbWAMIvf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030326AbWAMIvf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 03:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030325AbWAMIvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 03:51:35 -0500
Received: from smtp.osdl.org ([65.172.181.4]:28619 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030326AbWAMIve (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 03:51:34 -0500
Date: Fri, 13 Jan 2006 00:51:08 -0800
From: Andrew Morton <akpm@osdl.org>
To: dwmw2@infradead.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       drepper@redhat.com, dhowells@redhat.com
Subject: Re: [PATCH] [5/6] Handle TIF_RESTORE_SIGMASK for i386
Message-Id: <20060113005108.3ae42524.akpm@osdl.org>
In-Reply-To: <20060113004842.4c419174.akpm@osdl.org>
References: <1136923488.3435.78.camel@localhost.localdomain>
	<1136924357.3435.107.camel@localhost.localdomain>
	<20060112195950.60188acf.akpm@osdl.org>
	<1137126606.3085.44.camel@localhost.localdomain>
	<20060112205451.392c0c5c.akpm@osdl.org>
	<20060112221037.5dbc3dd9.akpm@osdl.org>
	<1137133408.3621.6.camel@pmac.infradead.org>
	<1137140937.2675.4.camel@localhost.localdomain>
	<20060113004842.4c419174.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> but x86 doesn't compile kernel/compat.c

But it usually compiles singal.c ;)  Hang on a mo..
