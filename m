Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263718AbTHZN4m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 09:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262698AbTHZN4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 09:56:42 -0400
Received: from angband.namesys.com ([212.16.7.85]:56961 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S263787AbTHZNyn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 09:54:43 -0400
Date: Tue, 26 Aug 2003 17:54:42 +0400
From: Oleg Drokin <green@namesys.com>
To: Christoph Hellwig <hch@lst.de>, marcelo@hera.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backport iget_locked from 2.5/2.6
Message-ID: <20030826135442.GB23462@namesys.com>
References: <20030825140714.GA17359@lst.de> <20030826112716.GA14680@namesys.com> <20030826134809.GA924@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030826134809.GA924@lst.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Mail-Followup-To: Christoph Hellwig <hch@angband.namesys.com>,

Hm, very interesting header, I'd say. No wonder I'm getting errors replying to
your emails.

On Tue, Aug 26, 2003 at 03:48:09PM +0200, Christoph Hellwig wrote:
> > The patch below does not achieve this. We still fill inode private part
> > outside of inode_lock locked region.
> -ENOPATCH :)

I meant the patch in the email you sent and to which I answered originally ;)

Bye,
    Oleg
