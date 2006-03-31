Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751068AbWCaGcp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbWCaGcp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 01:32:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbWCaGcp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 01:32:45 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:36578 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751068AbWCaGcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 01:32:45 -0500
Date: Fri, 31 Mar 2006 07:32:39 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Roland Dreier <rdreier@cisco.com>
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: Re: [openib-general] updated InfiniBand 2.6.17 merge plans
Message-ID: <20060331063239.GA31436@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Roland Dreier <rdreier@cisco.com>, openib-general@openib.org,
	linux-kernel@vger.kernel.org
References: <ada7j6f8xwi.fsf@cisco.com> <ada1wwj1r7r.fsf@cisco.com> <adawtebzfxm.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <adawtebzfxm.fsf@cisco.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2006 at 03:11:17PM -0800, Roland Dreier wrote:
> Oh yeah, one other thing I plan to merge unless someone objects:
> 
>  * Get rid of option for building IPoIB and mthca debug output unless EMBEDDED=y

NACK.  Just add a FOO_DEBUG config option, this has noþhing to do with
EMBEDDED.

