Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129364AbRBXOOm>; Sat, 24 Feb 2001 09:14:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129367AbRBXOOb>; Sat, 24 Feb 2001 09:14:31 -0500
Received: from u-53-20.karlsruhe.ipdial.viaginterkom.de ([62.180.20.53]:7923
	"EHLO dea.waldorf-gmbh.de") by vger.kernel.org with ESMTP
	id <S129364AbRBXOOQ>; Sat, 24 Feb 2001 09:14:16 -0500
Date: Sat, 24 Feb 2001 14:46:57 +0100
From: Ralf Baechle <ralf@uni-koblenz.de>
To: George <greerga@entropy.muc.muohio.edu>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Request: increase in PCI bus limit
Message-ID: <20010224144657.C5160@bacchus.dhis.org>
In-Reply-To: <20010131005519.D18746@cadcamlab.org> <Pine.LNX.4.30.0101311535130.24040-100000@entropy.muc.muohio.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0101311535130.24040-100000@entropy.muc.muohio.edu>; from greerga@entropy.muc.muohio.edu on Wed, Jan 31, 2001 at 03:38:55PM -0500
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2001 at 03:38:55PM -0500, George wrote:

> It's somewhat annoying that by choosing SMP NR_CPUS goes to 32 when I know
> I only have (and ever will have) 2 in this machine.  Don't make busses have
> the same assumptions that just waste memory.

It's just sad that bumping to NR_CPUS to 128 won't work that easily ;-)

  Ralf  (fixing that so he gets some machine time again ...)
