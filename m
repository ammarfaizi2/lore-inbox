Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262878AbVGMCEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262878AbVGMCEn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 22:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262529AbVGMCEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 22:04:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61340 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262612AbVGMCEl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 22:04:41 -0400
Date: Tue, 12 Jul 2005 19:02:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       prasanna@in.ibm.com
Subject: Re: [PATCH]Kprobes IA64 - Fix race when break hits and kprobe not
 found
Message-Id: <20050712190231.789da83c.akpm@osdl.org>
In-Reply-To: <20050712185230.A8528@unix-os.sc.intel.com>
References: <20050712185230.A8528@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com> wrote:
>
> This patch applies on top of  "Prasanna S Panchamukhi's" recent postings
>  Kprobes: Prevent possible race condition ia64 changes

I am not aware of such a patch.  Your patch hit a reject when I tried to
apply it to Linus's tree.  So I don't know what's going on..
