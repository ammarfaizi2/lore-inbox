Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261829AbVCOTnD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261829AbVCOTnD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 14:43:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261828AbVCOTk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 14:40:56 -0500
Received: from fire.osdl.org ([65.172.181.4]:60111 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261833AbVCOTiU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 14:38:20 -0500
Date: Tue, 15 Mar 2005 11:37:46 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jason Davis <jason@rightthere.net>
Cc: linux-kernel@vger.kernel.org, natalie.protasevich@unisys.com,
       jason.davis@unisys.com
Subject: Re: [PATCH] ES7000 Legacy Mappings Update
Message-Id: <20050315113746.2484c773.akpm@osdl.org>
In-Reply-To: <20050315152756.GA28799@righTThere.net>
References: <20050314183533.GA28889@righTThere.net>
	<20050314180554.10455185.akpm@osdl.org>
	<20050315152756.GA28799@righTThere.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Davis <jason@rightthere.net> wrote:
>
> I'll be glad to revise the patch to include enumerated identifiers but would it be more acceptable to comment on the semantics of the es7000_plat var in the platform specific "es7000plat.c" file?

I suppose that would suit.  It's not a huge issue..
