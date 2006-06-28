Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423374AbWF1RKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423374AbWF1RKK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 13:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422690AbWF1RKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 13:10:09 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:25002 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030361AbWF1RKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 13:10:06 -0400
Date: Wed, 28 Jun 2006 18:09:49 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Li Yang-r58472 <LeoLi@freescale.com>
Cc: "'Paul Mackerras'" <paulus@samba.org>, linuxppc-dev@ozlabs.org,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       Chu hanjin-r52514 <Hanjin.Chu@freescale.com>,
       Gridish Shlomi-RM96313 <gridish@freescale.com>,
       Phillips Kim-R1AAHA <Kim.Phillips@freescale.com>
Subject: Re: [PATCH 3/7] powerpc: Add QE library qe_lib--common files
Message-ID: <20060628170949.GB7162@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Li Yang-r58472 <LeoLi@freescale.com>,
	'Paul Mackerras' <paulus@samba.org>, linuxppc-dev@ozlabs.org,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	Chu hanjin-r52514 <Hanjin.Chu@freescale.com>,
	Gridish Shlomi-RM96313 <gridish@freescale.com>,
	Phillips Kim-R1AAHA <Kim.Phillips@freescale.com>
References: <9FCDBA58F226D911B202000BDBAD467306E04FD4@zch01exm40.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9FCDBA58F226D911B202000BDBAD467306E04FD4@zch01exm40.ap.freescale.net>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All these config options to descibe hardware variants are not acceptable.
Please describe the hardware layout in the device tree.

