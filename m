Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263449AbTE3IbK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 04:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263451AbTE3IbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 04:31:10 -0400
Received: from verein.lst.de ([212.34.189.10]:4070 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S263449AbTE3IbJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 04:31:09 -0400
Date: Fri, 30 May 2003 10:44:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@digeo.com>
Cc: Boszormenyi Zoltan <zboszor@freemail.hu>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.70-mm2
Message-ID: <20030530084419.GA29732@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@digeo.com>,
	Boszormenyi Zoltan <zboszor@freemail.hu>,
	linux-kernel@vger.kernel.org
References: <3ED70B9A.5050104@freemail.hu> <20030530012710.57cca756.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030530012710.57cca756.akpm@digeo.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -5 () EMAIL_ATTRIBUTION,IN_REP_TO,QUOTED_EMAIL_TEXT,REFERENCES,REPLY_WITH_QUOTES,USER_AGENT_MUTT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 30, 2003 at 01:27:10AM -0700, Andrew Morton wrote:
> > The line compares a struct ppa_struct* with a struct Scsi_Host *.
> > 
> 
> Christoph should be able to fix that one up.

There already was a patch posted on either lkml or linux-scsi.

