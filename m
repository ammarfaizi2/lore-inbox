Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751358AbWCVQ2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbWCVQ2N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 11:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbWCVQ2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 11:28:13 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:9396 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751353AbWCVQ2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 11:28:12 -0500
Date: Wed, 22 Mar 2006 16:28:03 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Frank Pavlic <fpavlic@de.ibm.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 1/6] s390: minor claw driver fix
Message-ID: <20060322162803.GA15580@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Frank Pavlic <fpavlic@de.ibm.com>, Jeff Garzik <jgarzik@pobox.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20060322160336.1becec81@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060322160336.1becec81@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2006 at 04:03:36PM +0100, Frank Pavlic wrote:
> Hi ,
> following 6 patches are for s390 network drivers claw, qeth and ctc.
> tty support will be removed from the ctc network device driver

Why?

