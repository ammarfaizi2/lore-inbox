Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262860AbVFVHmV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262860AbVFVHmV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 03:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262866AbVFVHk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 03:40:28 -0400
Received: from rgminet02.oracle.com ([148.87.122.31]:51515 "EHLO
	rgminet02.oracle.com") by vger.kernel.org with ESMTP
	id S261872AbVFVFYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:24:16 -0400
Date: Tue, 21 Jun 2005 22:23:50 -0700
From: Wim Coekaerts <wim.coekaerts@oracle.com>
To: Rik Van Riel <riel@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: OCFS (was Re: -mm -> 2.6.13 merge status)
Message-ID: <20050622052349.GA4923@ca-server1.us.oracle.com>
References: <20050620235458.5b437274.akpm@osdl.org> <Pine.LNX.4.61.0506212334010.4159@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0506212334010.4159@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.5.9i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2005 at 11:35:10PM -0400, Rik Van Riel wrote:
> On Mon, 20 Jun 2005, Andrew Morton wrote:
> 
> > git-ocfs
> The only problem I can see with this is that people will want
> to use OCFS together with CLVM, and both use a different cluster
> infrastructure.
> 
> IMHO it would be good if they both used the same underlying
> cluster infrastructure...

as clvm stuff and infra get submitted and come around we will definitely
be working with it. but it's a feature more than a requirement. altho we
have every intend to make our stuff work with clvm and I think some
pieces of ocfs2 are already being used or looked at to be used for this
infrastructure so it's looking good.

Wim
