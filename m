Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290164AbSAKXbi>; Fri, 11 Jan 2002 18:31:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290165AbSAKXb3>; Fri, 11 Jan 2002 18:31:29 -0500
Received: from oss.sgi.com ([216.32.174.27]:19902 "EHLO oss.sgi.com")
	by vger.kernel.org with ESMTP id <S290164AbSAKXbR>;
	Fri, 11 Jan 2002 18:31:17 -0500
Date: Thu, 10 Jan 2002 13:50:55 -0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Kervin Pierre <kpierre@fit.edu>
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Andreas Dilger <adilger@turbolabs.com>, linux-kernel@vger.kernel.org
Subject: Re: fs corruption recovery?
Message-ID: <20020110135055.A1703@dea.linux-mips.net>
In-Reply-To: <3C3BB082.8020204@fit.edu> <20020108200705.S769@lynx.adilger.int> <200201090326.g093QBF27608@vindaloo.ras.ucalgary.ca> <3C3BC38C.7010808@fit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C3BC38C.7010808@fit.edu>; from kpierre@fit.edu on Tue, Jan 08, 2002 at 11:14:04PM -0500
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2002 at 11:14:04PM -0500, Kervin Pierre wrote:

> Do you still have any of those scripts around? Or can you give me a 
> general idea of how you used debugfs to retrieve your files?

dd if=/dev/broken of=somefile conv=broken

> I was actually expecting to spend a few hundred instead of a few thousand.

Oh, the price tag for recovery of information from drive with heavier
physical damages are quite a bit juicier :-)

  Ralf
