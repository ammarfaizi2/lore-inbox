Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272666AbTG1FfK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 01:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272670AbTG1FfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 01:35:10 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:23776 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S272666AbTG1FfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 01:35:06 -0400
Date: Mon, 28 Jul 2003 07:50:15 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: "David S. Miller" <davem@redhat.com>
Cc: netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL] place IPv4 netfilter submenu where it belongs
Message-ID: <20030728055015.GA32673@louise.pinerecords.com>
References: <20030726200646.GF16160@louise.pinerecords.com> <20030727160942.647707d8.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030727160942.647707d8.davem@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [davem@redhat.com]
> 
> On Sat, 26 Jul 2003 22:06:46 +0200
> Tomas Szepe <szepe@pinerecords.com> wrote:
> 
> > $subj
> > 
> > Patch against -bk3.
> 
> This doesn't look right at all.
> 
> Netfilter is for many protocols other than ipv4 (ipv6, bridging,
> decnet, etc.) so putting it under ipv4 makes not much sense
> to me.

You're right, I'll think about this some more.

-- 
Tomas Szepe <szepe@pinerecords.com>
