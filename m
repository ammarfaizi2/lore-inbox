Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263801AbTHZNtG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 09:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263846AbTHZNtG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 09:49:06 -0400
Received: from verein.lst.de ([212.34.189.10]:42668 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S263801AbTHZNtF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 09:49:05 -0400
Date: Tue, 26 Aug 2003 15:48:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Oleg Drokin <green@namesys.com>
Cc: marcelo@hera.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backport iget_locked from 2.5/2.6
Message-ID: <20030826134809.GA924@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, Oleg Drokin <green@namesys.com>,
	marcelo@hera.kernel.org, linux-kernel@vger.kernel.org
References: <20030825140714.GA17359@lst.de> <20030826112716.GA14680@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030826112716.GA14680@namesys.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -5 () EMAIL_ATTRIBUTION,IN_REP_TO,QUOTED_EMAIL_TEXT,REFERENCES,REPLY_WITH_QUOTES,USER_AGENT_MUTT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 26, 2003 at 03:27:16PM +0400, Oleg Drokin wrote:
> The patch below does not achieve this. We still fill inode private part
> outside of inode_lock locked region.

-ENOPATCH :)

