Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261212AbVDSIuN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbVDSIuN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 04:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbVDSIuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 04:50:13 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:53735 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261212AbVDSIuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 04:50:10 -0400
Date: Tue, 19 Apr 2005 09:50:08 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Olivier Galibert <galibert@pobox.com>,
       "Hack inc." <linux-kernel@vger.kernel.org>
Subject: Re: Can a non-sg scsi write command be more than PAGE_SIZE length?
Message-ID: <20050419085008.GA9194@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Olivier Galibert <galibert@pobox.com>,
	"Hack inc." <linux-kernel@vger.kernel.org>
References: <20050419084730.GA96767@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050419084730.GA96767@dspnet.fr.eu.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2005 at 10:47:30AM +0200, Olivier Galibert wrote:
> ...or more importantly, is it allowed.  Kernel is FC3 2.6.10-1.766.

Yes, it's allowed.

