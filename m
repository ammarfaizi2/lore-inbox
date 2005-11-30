Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751441AbVK3Q0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbVK3Q0Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 11:26:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbVK3Q0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 11:26:25 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:39143 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751447AbVK3Q0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 11:26:24 -0500
Date: Wed, 30 Nov 2005 16:26:23 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
Cc: linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: [PATCH 1/1] elevator: indirect function calls reducing
Message-ID: <20051130162623.GB15273@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Ananiev, Leonid I" <leonid.i.ananiev@intel.com>,
	linux-kernel@vger.kernel.org, axboe@suse.de
References: <6694B22B6436BC43B429958787E4549892AE56@mssmsx402nb>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6694B22B6436BC43B429958787E4549892AE56@mssmsx402nb>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


this _still_ isn't an indirect function call reduction and people
have told you N times.  Please get your basics right first, to start
with the patch description.

