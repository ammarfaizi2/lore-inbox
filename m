Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266543AbUFQPCV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266543AbUFQPCV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 11:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266526AbUFQPBB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 11:01:01 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23006 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266525AbUFQO6f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 10:58:35 -0400
Date: Thu, 17 Jun 2004 10:58:08 -0400
From: Alan Cox <alan@redhat.com>
To: James Bottomley <James.Bottomley@SteelEye.com>, y@redhat.com
Cc: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>,
       Christoph Hellwig <hch@infradead.org>, Alan Cox <alan@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: PATCH: Further aacraid work
Message-ID: <20040617145808.GA29938@devserv.devel.redhat.com>
References: <547AF3BD0F3F0B4CBDC379BAC7E4189FD2402C@otce2k03.adaptec.com> <1087484107.2090.42.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1087484107.2090.42.camel@mulgrave>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2004 at 09:55:03AM -0500, James Bottomley wrote:
> This is hardly a big problem, is it?  it only occurs during the first
> few moments of system operation.  After that, the pages assigned to a
> virtual region are pretty much random.

When I looked at it (which I grant was 2.2 and 2.4 the pattern was
visible on machines that had been running for a week or more)

