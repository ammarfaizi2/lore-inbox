Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266534AbUAWHgt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 02:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266535AbUAWHgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 02:36:49 -0500
Received: from fw.osdl.org ([65.172.181.6]:18064 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266534AbUAWHgs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 02:36:48 -0500
Date: Thu, 22 Jan 2004 23:37:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: davej@redhat.com
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: DMI updates from 2.4
Message-Id: <20040122233734.3ffe096b.akpm@osdl.org>
In-Reply-To: <E1Ajuub-0000x4-00@hardwired>
References: <E1Ajuub-0000x4-00@hardwired>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

davej@redhat.com wrote:
>
> +static __init int apm_is_horked_d850md(struct dmi_blacklist *d)

this new function is unreferenced.
