Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751052AbWBSWJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbWBSWJd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 17:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751062AbWBSWJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 17:09:33 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:40064 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751052AbWBSWJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 17:09:32 -0500
Date: Sun, 19 Feb 2006 22:09:29 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Paul Mundt <lethal@linux-sh.org>, Dave Jones <davej@redhat.com>,
       Greg KH <greg@kroah.com>, Christoph Hellwig <hch@infradead.org>,
       zanussi@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] relayfs: Convert to generic relay API.
Message-ID: <20060219220929.GA14245@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Paul Mundt <lethal@linux-sh.org>, Dave Jones <davej@redhat.com>,
	Greg KH <greg@kroah.com>, zanussi@us.ibm.com,
	linux-kernel@vger.kernel.org
References: <20060219210733.GA3682@linux-sh.org> <20060219212122.GA7974@redhat.com> <20060219212748.GA4690@linux-sh.org> <20060219215432.GB4690@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060219215432.GB4690@linux-sh.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 19, 2006 at 11:54:32PM +0200, Paul Mundt wrote:
> This strips down relayfs to a minimum, removing everything already
> provided by CONFIG_RELAY. This leaves a userspace API compatible
> implementation on top of the new framework.

not needed given there's no user yet.

