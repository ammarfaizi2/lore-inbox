Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbTKTNEu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 08:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261740AbTKTNEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 08:04:50 -0500
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:49930 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261724AbTKTNEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 08:04:50 -0500
Date: Thu, 20 Nov 2003 13:04:32 +0000
From: Christoph Hellwig <hch@infradead.org>
To: =?iso-8859-1?Q?Diego_Calleja_Garc=EDa?= <aradorlinux@yahoo.es>
Cc: Nick Piggin <piggin@cyberone.com.au>, wli@holomorphy.com,
       jgarzik@pobox.com, jt@hpl.hp.com, linux-kernel@vger.kernel.org,
       pof@users.sourceforge.net
Subject: Re: Announce: ndiswrapper
Message-ID: <20031120130432.A30975@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	=?iso-8859-1?Q?Diego_Calleja_Garc=EDa?= <aradorlinux@yahoo.es>,
	Nick Piggin <piggin@cyberone.com.au>, wli@holomorphy.com,
	jgarzik@pobox.com, jt@hpl.hp.com, linux-kernel@vger.kernel.org,
	pof@users.sourceforge.net
References: <20031120031137.GA8465@bougret.hpl.hp.com> <3FBC3483.4060706@pobox.com> <20031120040034.GF19856@holomorphy.com> <3FBC402E.6070109@cyberone.com.au> <20031120043848.GG19856@holomorphy.com> <3FBC4A42.8010806@cyberone.com.au> <20031120134121.02e11aff.aradorlinux@yahoo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031120134121.02e11aff.aradorlinux@yahoo.es>; from aradorlinux@yahoo.es on Thu, Nov 20, 2003 at 01:41:21PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 20, 2003 at 01:41:21PM +0100, Diego Calleja García wrote:
> "windows driver model" abi which doesn't change even between W9x and nt)

that's what microsoft PR says.  in fact it's rather difficult to have a driver
working on win9x and nt without very ugly hacks.  And for some driver classes
it doesn't work at all.

