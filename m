Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268947AbUHZM6T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268947AbUHZM6T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 08:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268983AbUHZMyG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 08:54:06 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:15626 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268857AbUHZMxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 08:53:10 -0400
Date: Thu, 26 Aug 2004 13:52:49 +0100
From: Christoph Hellwig <hch@infradead.org>
To: =?iso-8859-1?Q?Markus_T=F6rnqvist?= <mjt@nysv.org>
Cc: Olivier Galibert <galibert@pobox.com>,
       Christian Mayrhuber <christian.mayrhuber@gmx.net>,
       reiserfs-list@namesys.com, Anton Altaparmakov <aia21@cam.ac.uk>,
       linux-fsdevel@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826135249.A19347@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	=?iso-8859-1?Q?Markus_T=F6rnqvist?= <mjt@nysv.org>,
	Olivier Galibert <galibert@pobox.com>,
	Christian Mayrhuber <christian.mayrhuber@gmx.net>,
	reiserfs-list@namesys.com, Anton Altaparmakov <aia21@cam.ac.uk>,
	linux-fsdevel@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
References: <20040824202521.GA26705@lst.de> <20040825163225.4441cfdd.akpm@osdl.org> <1093510983.23289.6.camel@imp.csi.cam.ac.uk> <200408261245.47734.christian.mayrhuber@gmx.net> <20040826115229.A18013@infradead.org> <20040826124334.GA39176@dspnet.fr.eu.org> <20040826134415.A19244@infradead.org> <20040826124929.GW1284@nysv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040826124929.GW1284@nysv.org>; from mjt@nysv.org on Thu, Aug 26, 2004 at 03:49:29PM +0300
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 03:49:29PM +0300, Markus Törnqvist wrote:
> 2.7 might not be a bad idea for trying such bleeding edge revolution
> stuff as this.

I already suggested to Linus that 2.7 is probably the right place to
experiment with that.

