Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbVCAEca@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbVCAEca (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 23:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261240AbVCAEca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 23:32:30 -0500
Received: from fire.osdl.org ([65.172.181.4]:18089 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261234AbVCAEcX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 23:32:23 -0500
Date: Mon, 28 Feb 2005 20:31:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: jmorris@redhat.com, linux-kernel@vger.kernel.org, sds@epoch.ncsc.mil,
       alexn@dsv.su.se
Subject: Re: [PATCH] SELinux: null dereference in error path
Message-Id: <20050228203152.4eea9170.akpm@osdl.org>
In-Reply-To: <F00DE41E-8A09-11D9-858B-000393ACC76E@mac.com>
References: <Xine.LNX.4.44.0502282311190.26032-100000@thoron.boston.redhat.com>
	<F00DE41E-8A09-11D9-858B-000393ACC76E@mac.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett <mrmacman_g4@mac.com> wrote:
>
> Err, isn't it "Acked-by:"??

Yes, I usually change it to Acked-by when it's obvious.

Signed-off-by:  "I worked on this patch"
Acked-by:       "Looks good"
Tested-by:      "You're kidding"
