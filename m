Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261659AbUJ0FyB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbUJ0FyB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 01:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbUJ0FyB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 01:54:01 -0400
Received: from fw.osdl.org ([65.172.181.6]:46795 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261659AbUJ0Fxj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 01:53:39 -0400
Date: Tue, 26 Oct 2004 22:51:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au, vojtech@suse.cz
Subject: Re: 2.6.10-rc1-mm1
Message-Id: <20041026225135.7ca1eb58.akpm@osdl.org>
In-Reply-To: <200410270042.34224.dtor_core@ameritech.net>
References: <20041026213156.682f35ca.akpm@osdl.org>
	<200410270042.34224.dtor_core@ameritech.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov <dtor_core@ameritech.net> wrote:
>
>  Please consider applying the patch below for parkbd instead of
>  Rusty's changes.

Please just put it in your bk tree and that'll toss out Rusty's bits.
