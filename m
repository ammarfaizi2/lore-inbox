Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261328AbVB0CQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbVB0CQf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 21:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbVB0CQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 21:16:35 -0500
Received: from fire.osdl.org ([65.172.181.4]:26857 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261328AbVB0CQe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 21:16:34 -0500
Date: Sat, 26 Feb 2005 18:15:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: Matthias.Kunze@gmx-topmail.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] config option for default loglevel
Message-Id: <20050226181552.126e3f25.akpm@osdl.org>
In-Reply-To: <20050227030431.46496c7a.Matthias.Kunze@gmx-topmail.de>
References: <20050226190556.0def242c.Matthias.Kunze@gmx-topmail.de>
	<20050226154505.43889139.akpm@osdl.org>
	<20050227030431.46496c7a.Matthias.Kunze@gmx-topmail.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Kunze <Matthias.Kunze@gmx-topmail.de> wrote:
>
> I've added the boot option, it will override the compile-time option.

I don't see a need for the compile-time option now..
