Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266730AbUH1JS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266730AbUH1JS7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 05:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266741AbUH1JS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 05:18:58 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:23307 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266730AbUH1JS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 05:18:58 -0400
Date: Sat, 28 Aug 2004 10:18:49 +0100
From: Christoph Hellwig <hch@infradead.org>
To: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>,
       Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org
Subject: Re: [1/4] standardize bit waiting data type
Message-ID: <20040828101849.A7592@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, Oleg Nesterov <oleg@tv-sign.ru>,
	linux-kernel@vger.kernel.org
References: <20040826014745.225d7a2c.akpm@osdl.org> <20040828052627.GA2793@holomorphy.com> <20040828053112.GB2793@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040828053112.GB2793@holomorphy.com>; from wli@holomorphy.com on Fri, Aug 27, 2004 at 10:31:12PM -0700
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Why __wkae_up_bit, not wake_up_bit?

