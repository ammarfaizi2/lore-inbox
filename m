Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286387AbRLTV1Q>; Thu, 20 Dec 2001 16:27:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286386AbRLTV1G>; Thu, 20 Dec 2001 16:27:06 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:44024 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S286387AbRLTV0w>;
	Thu, 20 Dec 2001 16:26:52 -0500
Date: Thu, 20 Dec 2001 14:25:56 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: =?iso-8859-1?Q?G=E1bor_L=E9n=E1rt?= <lgb@lgb.hu>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Changing KB, MB, and GB to KiB, MiB, and GiB in Configure.help.
Message-ID: <20011220142556.C2694@lynx.no>
Mail-Followup-To: =?iso-8859-1?Q?G=E1bor_L=E9n=E1rt?= <lgb@lgb.hu>,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011220203223.GO7414@vega.digitel2002.hu> <Pine.LNX.3.95.1011220155155.8609A-100000@chaos.analogic.com> <20011220211422.GS7414@vega.digitel2002.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.4i
In-Reply-To: <20011220211422.GS7414@vega.digitel2002.hu>; from lgb@lgb.hu on Thu, Dec 20, 2001 at 10:14:22PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 20, 2001  22:14 +0100, Gábor Lénárt wrote:
> > everybody uses K for kilo and it's as absolutely incorrect as possible.
> > The existing symbols work by fiat. You can't make them "correct" by
> > following incorrect rules.
> 
> Oh well, sorry, so let's say about 'k' and 'm'. However an engineer friend
> of mine has just say that 'K' is 1024, and 'k' is 1000 ... I dunno anymore ...

Well, they are wrong, because 'K' is Kelvin, and not kilo-.

> [however I've never seen 'Kg' instead of 'kg', but 'mB' or 'mb' are ugly
> when compared with 'Mb' and 'MB', not counting that 'b' is bit and 'B' is
> byte ... well ... it's confusing sometimes ...]

Especially since few people work on 1/1000 of a byte (i.e. 'm' is milli,
like mm=millimeter, and not 'M' which is Mega-).  So mB and mb are just
plain wrong.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

