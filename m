Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285031AbRLZXfc>; Wed, 26 Dec 2001 18:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285047AbRLZXfW>; Wed, 26 Dec 2001 18:35:22 -0500
Received: from msp-150.man.olsztyn.pl ([213.184.31.150]:17282 "EHLO
	msp-150.man.olsztyn.pl") by vger.kernel.org with ESMTP
	id <S285031AbRLZXfP>; Wed, 26 Dec 2001 18:35:15 -0500
Date: Thu, 27 Dec 2001 00:34:13 +0100
From: Dominik Mierzejewski <dominik@aaf16.warszawa.sdi.tpnet.pl>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Configure.help editorial policy
Message-ID: <20011226233413.GA17037@msp-150.man.olsztyn.pl>
In-Reply-To: <20011223174608.A25335@thyrsus.com> <Pine.LNX.4.21.0112261718150.32161-100000@Consulate.UFP.CX> <20011227091702.A8528@zapff.research.canon.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011227091702.A8528@zapff.research.canon.com.au>
User-Agent: Mutt/1.3.24i
X-Linux-Registered-User: 134951
X-Homepage: http://home.elka.pw.edu.pl/~dmierzej/
X-PGP-Key-Fingerprint: B546 B96A 4258 02EF 5CAB  E867 3CDA 420F 7802 6AFE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 26 December 2001, Cameron Simpson wrote:
> On Wed, Dec 26, 2001 at 05:44:36PM +0000, Riley Williams <rhw@memalpha.cx> wrote:
> | >> I take it this is your way of volunteering to always keep all
> | >> kernel documentation accurate as well as answer questions from
> | >> newbies who've never seen 'KiB' before ? ;)
> | 
> | > One of the arguments for the KiB declaration, despite the ugliness
> | > of "kibibytes", is that a newbie seeing "32KiB" is quite likely to
> | > deduce what's meant from context.  Let's not exaggerate the
> | > difficulties here.
> | 
> | Alternatively, deal with this problem the same way the "This may also be
> | built as a module..." comment is - either include it several thousand
> | times in Configure.help or (better still) have the configuration tools
> | spit it out automatically every time the need for it crops up. The
> | following ruleset could easily be implemented even in the `make config`
> | and `make menuconfig` parsers, and should be just as easy in CML2.
> | Applying rule (1) will result in a considerable reduction in the size of
> | the file Documentation/Configure.help as it currently stands.
> | 
> | Comments, anybody?
> 
> I like this!

I second this. Being a translator of the file in question, I have to deal
with ten slightly different versions of "You may also compile this as
a module...". So I have ten slighlty different translations of this text,
too, in the name of accuracy.

Although I thought there was an agreement that decimal kilobyte is kB,
and binary kilobyte is KiB, decimal megabyte is MB, binary megabyte is MB
and so on, wasn't there?
 
-- 
"The Universe doesn't give you any points for doing things that are easy."
        -- Sheridan to Garibaldi in Babylon 5:"The Geometry of Shadows"
Dominik 'Rathann' Mierzejewski <rathann(at)we.are.one.pl>
