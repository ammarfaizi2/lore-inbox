Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263633AbRFKTN7>; Mon, 11 Jun 2001 15:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263630AbRFKTNv>; Mon, 11 Jun 2001 15:13:51 -0400
Received: from iris.mc.com ([192.233.16.119]:42963 "EHLO mc.com")
	by vger.kernel.org with ESMTP id <S263607AbRFKTNi>;
	Mon, 11 Jun 2001 15:13:38 -0400
From: Mark Salisbury <mbs@mc.com>
To: Troy Benjegerdes <hozer@drgw.net>,
        Zehetbauer Thomas <TZ@link.topcall.co.at>
Subject: Re: IBM PPC 405 series little endian?
Date: Mon, 11 Jun 2001 15:08:26 -0400
X-Mailer: KMail [version 1.0.29]
Content-Type: text/plain; charset=US-ASCII
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <41EA756DBC9FD0118CFC0020AFDB5C5A188DE7@tcint1ntsrv> <20010611133949.Q753@altus.drgw.net>
In-Reply-To: <20010611133949.Q753@altus.drgw.net>
MIME-Version: 1.0
Message-Id: <01061115111305.01190@pc-eng24.mc.com>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jun 2001, Troy Benjegerdes wrote:
> On Mon, Jun 11, 2001 at 01:34:21PM +0200, Zehetbauer Thomas wrote:
> > Has someone experimented with running linux in little-endian mode on IBM
> > PowerPC 405 (Walnut) yet?
> 
> With the possible exception of the matrox guy, I haven't heard of ANYONE 
> running in LE mode on ppc. The second problem is going to be to recompile 
> ALL the applications you want and hope they work.

actually, we run ppc 603, 750 and 74xx series ppc's little endian in a PCI
based shared memory multicomputer.

we also run them big-endian in the VME based version.
-- 
/*------------------------------------------------**
**   Mark Salisbury | Mercury Computer Systems    **
**   mbs@mc.com     | System OS - Kernel Team     **
**------------------------------------------------**

