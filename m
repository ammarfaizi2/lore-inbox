Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266246AbUGATsY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266246AbUGATsY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 15:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266244AbUGATsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 15:48:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:50393 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266236AbUGATsW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 15:48:22 -0400
Date: Thu, 1 Jul 2004 12:46:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: Peter Martuccelli <peterm@redhat.com>
Cc: peterm@redhat.com, faith@redhat.com, davidm@hpl.hp.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       ray.lanza@hp.com
Subject: Re: [PATCH] IA64 audit support
Message-Id: <20040701124644.5e301ca0.akpm@osdl.org>
In-Reply-To: <200406301556.i5UFuGg8009251@redrum.boston.redhat.com>
References: <200406301556.i5UFuGg8009251@redrum.boston.redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Martuccelli <peterm@redhat.com> wrote:
>
>  Here is one of the audit tasks we talked about.  This patch adds 
>  ia64 support to the audit subsystem.  I have tested the ia64 audit 
>  support without any issues to report. The original patch was from
>  from Ray Lanza.

It's nice and simple.

> Requesting patch to be merged in the next version. 

Via davidm, please.
