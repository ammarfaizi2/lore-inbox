Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262510AbVCVGKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262510AbVCVGKr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 01:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262337AbVCVGGB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 01:06:01 -0500
Received: from fire.osdl.org ([65.172.181.4]:16092 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262491AbVCVGEy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 01:04:54 -0500
Date: Mon, 21 Mar 2005 22:04:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: Prarit Bhargava <prarit@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC]: DEBUG for PCI IO & MEM allocation
Message-Id: <20050321220436.72c1c4f6.akpm@osdl.org>
In-Reply-To: <423F288F.7010202@sgi.com>
References: <4235C88B.9090708@sgi.com>
	<20050314212812.3657cfd4.akpm@osdl.org>
	<423F288F.7010202@sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prarit Bhargava <prarit@sgi.com> wrote:
>
>  >Shouldn't this also be printing the ->name of the new resource?
>  >
>  >A lot of the statements which you're adding will look screwy in an 80-col
>  >xterm.  Please wrap 'em.
>  >
>  -- new patch with Andrew's comments fixed.

OK, but I've forgotten the rationale for this change - please send through
a little changelog entry and a Signed-off-by: line and I'll push this in
Greg's direction.

Thanks.
