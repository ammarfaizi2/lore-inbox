Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261433AbVAGOqs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbVAGOqs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 09:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261441AbVAGOqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 09:46:48 -0500
Received: from [213.146.154.40] ([213.146.154.40]:16574 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261433AbVAGOqq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 09:46:46 -0500
Date: Fri, 7 Jan 2005 14:46:44 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Vladimir Saveliev <vs@namesys.com>
Cc: Hans Reiser <reiser@namesys.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>,
       Alexander Zarochentcev <zam@namesys.com>
Subject: Re: 2.6.10-mm1
Message-ID: <20050107144644.GA9606@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Vladimir Saveliev <vs@namesys.com>,
	Hans Reiser <reiser@namesys.com>, Andrew Morton <akpm@osdl.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>,
	Alexander Zarochentcev <zam@namesys.com>
References: <20050103011113.6f6c8f44.akpm@osdl.org> <20050103114854.GA18408@infradead.org> <41DC2386.9010701@namesys.com> <1105019521.7074.79.camel@tribesman.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105019521.7074.79.camel@tribesman.namesys.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 04:52:01PM +0300, Vladimir Saveliev wrote:
> The work is in progress. Here is list of patches. 
 
> reiser4-perthread-pages.patch

this one I don't particularly object, but I'm not sure it's really
the right thing to do.  Can you post it with a detailed description
to linux-mm so we can kick off discussion?

The other thing I'm totally oposed to was the per-sb kobject patch,
but I can't find that in current -mm anymore.

