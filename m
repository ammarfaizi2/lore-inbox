Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965034AbWCULO7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965034AbWCULO7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 06:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965039AbWCULO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 06:14:59 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:49886 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965034AbWCULO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 06:14:58 -0500
Date: Tue, 21 Mar 2006 11:14:52 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Richard J Moore <richardj_moore@uk.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, ak@suse.de, davem@davemloft.net,
       linux-kernel@vger.kernel.org, prasanna@in.ibm.com, suparna@in.ibm.com
Subject: Re: [2/3 PATCH] Kprobes: User space probes support- readpage hooks
Message-ID: <20060321111452.GA5460@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Richard J Moore <richardj_moore@uk.ibm.com>,
	Andrew Morton <akpm@osdl.org>, ak@suse.de, davem@davemloft.net,
	linux-kernel@vger.kernel.org, prasanna@in.ibm.com,
	suparna@in.ibm.com
References: <20060320181255.16932b0d.akpm@osdl.org> <OFB22908E4.CE9C1F2E-ON80257138.0030CAF3-80257138.0032BABE@uk.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFB22908E4.CE9C1F2E-ON80257138.0030CAF3-80257138.0032BABE@uk.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> A real life example of where this capability would have been very useful is
> with a performance problem I am currently investigating. It involves a GPFS
> + SAMBA + TCPIP +  RDAC

this pobablt tells more about the crappy code quality of your propritary
code than a real need for this.   please argue without reference to huge
blobs of junk.

