Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932405AbVHWVlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405AbVHWVlr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 17:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbVHWVlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 17:41:47 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48053 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S932399AbVHWVlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 17:41:46 -0400
Date: Tue, 23 Aug 2005 22:44:39 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: davej@redhat.com, jgarzik@pobox.com, linux-kernel@vger.kernel.org,
       mlindner@syskonnect.de
Subject: Re: skge missing ifdefs.
Message-ID: <20050823214439.GG9322@parcelfarce.linux.theplanet.co.uk>
References: <20050801203442.GD2473@redhat.com> <20050801203818.GA7497@havoc.gtf.org> <20050822195913.GF27344@redhat.com> <20050822132333.2ff893e6.akpm@osdl.org> <20050822203522.GB9322@parcelfarce.linux.theplanet.co.uk> <20050822134218.55de5b82.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050822134218.55de5b82.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2005 at 01:42:18PM -0700, Andrew Morton wrote:
> Al Viro <viro@parcelfarce.linux.theplanet.co.uk> wrote:
> >
> > mail -s '[PATCH] (45/46) %t... in vsnprintf' torvalds@osdl.org <<'EOF'
> 
> <wonders what the other 45 patches did>
> 
> Could you copy a mailing list on patches, please?

Ask and you shall regret it - next iteration of patchbomb (without adding
more pending chunks to it) Cc'd to l-k.
