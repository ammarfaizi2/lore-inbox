Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266762AbUFYPzc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266762AbUFYPzc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 11:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266774AbUFYPzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 11:55:32 -0400
Received: from [213.146.154.40] ([213.146.154.40]:37306 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S266762AbUFYPz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 11:55:28 -0400
Date: Fri, 25 Jun 2004 16:53:35 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Erik Jacobson <erikj@subway.americas.sgi.com>,
       Andrew Morton <akpm@osdl.org>, Pat Gefre <pfg@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] Altix serial driver
Message-ID: <20040625155335.GA30427@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jesse Barnes <jbarnes@engr.sgi.com>,
	Erik Jacobson <erikj@subway.americas.sgi.com>,
	Andrew Morton <akpm@osdl.org>, Pat Gefre <pfg@sgi.com>,
	linux-kernel@vger.kernel.org
References: <Pine.SGI.3.96.1040623094239.19458C-100000@fsgi900.americas.sgi.com> <Pine.SGI.4.53.0406242153360.343801@subway.americas.sgi.com> <20040625083130.GA26557@infradead.org> <200406251110.07383.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406251110.07383.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2004 at 11:10:07AM -0400, Jesse Barnes wrote:
> But LANANA doesn't assign minors, right?  And Linus hasn't banned those, so 
> the patch to devices.txt should be sufficient, right?  (Please let the answer 
> be yes!)  Moreover, isn't this Andrew's decision as the 2.6 maintainer?

For the misc major LANANA also assigns minors.

