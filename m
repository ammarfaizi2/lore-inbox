Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315120AbSHML3I>; Tue, 13 Aug 2002 07:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315167AbSHML3I>; Tue, 13 Aug 2002 07:29:08 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:52745 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S315120AbSHML3H>; Tue, 13 Aug 2002 07:29:07 -0400
Date: Tue, 13 Aug 2002 12:32:55 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Stephane Wirtel <stephane.wirtel@belgacom.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20-pre2 compile error
Message-ID: <20020813123255.A5393@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Stephane Wirtel <stephane.wirtel@belgacom.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20020813103024.GD31522@stargate.lan> <Pine.NEB.4.44.0208131236140.14606-100000@mimas.fachschaften.tu-muenchen.de> <20020813110138.GF31522@stargate.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020813110138.GF31522@stargate.lan>; from stephane.wirtel@belgacom.net on Tue, Aug 13, 2002 at 01:01:38PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2002 at 01:01:38PM +0200, Stephane Wirtel wrote:
> are you sure that the "int number" is employed only by devfs?

Yes, it is.   And I'm pissed that it neither was depend on the devfs config option
nor had a devfsﬂrelated named for a long time.  Richard just bloats the whole kernel
woth devfs crap all over the place.

