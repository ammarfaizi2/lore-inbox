Return-Path: <linux-kernel-owner+w=401wt.eu-S1758771AbWLIEq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758771AbWLIEq0 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 23:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758817AbWLIEqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 23:46:25 -0500
Received: from smtp.osdl.org ([65.172.181.25]:44643 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758771AbWLIEqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 23:46:25 -0500
Date: Fri, 8 Dec 2006 20:46:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: Vitaly Wool <vitalywool@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][resend] fix PNX8550 serial breakage
Message-Id: <20061208204622.8d93fda7.akpm@osdl.org>
In-Reply-To: <20061207182439.b571ecda.vitalywool@gmail.com>
References: <20061207182439.b571ecda.vitalywool@gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2006 18:24:39 +0300
Vitaly Wool <vitalywool@gmail.com> wrote:

> inlined is the patch (being resent) that fixes the serial header breakage for the PNX8550 MIPS platform.

When sending a fix please include a full description of the problem which
is being fixed, and a description of how the patch fixes it, if that is
not utterly obvious.

Thanks.
