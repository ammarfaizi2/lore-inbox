Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261334AbULUS56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbULUS56 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 13:57:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261283AbULUS56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 13:57:58 -0500
Received: from [213.146.154.40] ([213.146.154.40]:22437 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261337AbULUS5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 13:57:42 -0500
Date: Tue, 21 Dec 2004 18:57:39 +0000
From: Christoph Hellwig <hch@infradead.org>
To: long <tlnguyen@snoqualmie.dp.intel.com>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, tom.l.nguyen@intel.com
Subject: Re: [PATCH]PCI Express Port Bus Driver
Message-ID: <20041221185739.GA329@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	long <tlnguyen@snoqualmie.dp.intel.com>, greg@kroah.com,
	linux-kernel@vger.kernel.org, tom.l.nguyen@intel.com
References: <200412211921.iBLJLLwG007091@snoqualmie.dp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412211921.iBLJLLwG007091@snoqualmie.dp.intel.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Any reason the new files aren't just under drivers/pci/ ?

