Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271270AbTGWUAa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 16:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271272AbTGWUAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 16:00:30 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:43527 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S271270AbTGWUA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 16:00:29 -0400
Date: Wed, 23 Jul 2003 21:15:33 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, uclinux-dev@uclinux.org,
       linux-kernel@vger.kernel.org
Subject: Re: [uClinux-dev] Kernel 2.6 size increase
Message-ID: <20030723211533.A434@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"David S. Miller" <davem@redhat.com>,
	Christoph Hellwig <hch@lst.de>, uclinux-dev@uclinux.org,
	linux-kernel@vger.kernel.org
References: <200307232046.46990.bernie@develer.com> <20030723193246.GA836@lst.de> <20030723131154.472172d0.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030723131154.472172d0.davem@redhat.com>; from davem@redhat.com on Wed, Jul 23, 2003 at 01:11:54PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 23, 2003 at 01:11:54PM -0700, David S. Miller wrote:
> Careful, some platforms won't work with this.

I didn't say I want this changed again in mainline, I just
wanted to see whether gcc actually is smarter than us so we
need to remove some more inlines..

