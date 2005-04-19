Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261415AbVDSJYf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261415AbVDSJYf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 05:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbVDSJYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 05:24:35 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:23059 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S261415AbVDSJYe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 05:24:34 -0400
Date: Tue, 19 Apr 2005 11:24:31 +0200
From: Olivier Galibert <galibert@pobox.com>
To: Christoph Hellwig <hch@infradead.org>,
       "Hack inc." <linux-kernel@vger.kernel.org>
Subject: Re: Can a non-sg scsi write command be more than PAGE_SIZE length?
Message-ID: <20050419092431.GA98975@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Christoph Hellwig <hch@infradead.org>,
	"Hack inc." <linux-kernel@vger.kernel.org>
References: <20050419084730.GA96767@dspnet.fr.eu.org> <20050419085008.GA9194@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050419085008.GA9194@infradead.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2005 at 09:50:08AM +0100, Christoph Hellwig wrote:
> On Tue, Apr 19, 2005 at 10:47:30AM +0200, Olivier Galibert wrote:
> > ...or more importantly, is it allowed.  Kernel is FC3 2.6.10-1.766.
> 
> Yes, it's allowed.

Thanks.  Pages in that case are continuous then, right?

  OG.
