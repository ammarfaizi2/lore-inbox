Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267528AbUG2Xbx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267528AbUG2Xbx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 19:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267541AbUG2Xbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 19:31:52 -0400
Received: from fw.osdl.org ([65.172.181.6]:34994 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267528AbUG2Xao (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 19:30:44 -0400
Date: Thu, 29 Jul 2004 16:34:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to increase max number of groups per uid ?
Message-Id: <20040729163407.02bb2dd6.akpm@osdl.org>
In-Reply-To: <20040729193106.43d4c515.skraw@ithnet.com>
References: <20040729193106.43d4c515.skraw@ithnet.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan von Krawczynski <skraw@ithnet.com> wrote:
>
> is there a simple way in either 2.4 or 2.6 to get a lot more than 32 groups per
> uid?

2.6 kernels support up to 65536 groups per user.
