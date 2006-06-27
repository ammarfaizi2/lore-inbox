Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932435AbWF0Gn1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbWF0Gn1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 02:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932472AbWF0Gn1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 02:43:27 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:32440 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932435AbWF0Gn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 02:43:26 -0400
Subject: Re: GFS2 and DLM
From: Arjan van de Ven <arjan@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Christoph Hellwig <hch@infradead.org>,
       Steven Whitehouse <swhiteho@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>,
       David Teigland <teigland@redhat.com>,
       Patrick Caulfield <pcaulfie@redhat.com>,
       Kevin Anderson <kanderso@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060627063339.GA27938@elte.hu>
References: <1150805833.3856.1356.camel@quoit.chygwyn.com>
	 <20060623144928.GA32694@infradead.org> <20060626200300.GA15424@elte.hu>
	 <20060627063339.GA27938@elte.hu>
Content-Type: text/plain
Date: Tue, 27 Jun 2006 08:43:20 +0200
Message-Id: <1151390601.2879.16.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Btw., i have just taken a 5 minute tour into XFS, and i found at least 5 
> other problems with the XFS code that are similar in nature to the ones 
> you pointed out. 

that's no reason to merge even more junk

> (mostly useless wrappers around Linux functionality) 
> Isnt this whole episode highly hypocritic to begin with?

lets not start calling names please...


