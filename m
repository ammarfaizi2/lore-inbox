Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272284AbTG3Vcr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 17:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272286AbTG3Vcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 17:32:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:15250 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272284AbTG3Vcp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 17:32:45 -0400
Date: Wed, 30 Jul 2003 14:21:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O11.2int for interactivity
Message-Id: <20030730142101.56064e67.akpm@osdl.org>
In-Reply-To: <200307310728.56863.kernel@kolivas.org>
References: <200307310728.56863.kernel@kolivas.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> wrote:
>
> This patch backs out a little section which isn't quite right and 
> just might in the wrong circumstances cause unfairness. Goes on
> top of O11.1

'k, thanks.  I'll do -mm2 about eight hours from now.

