Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314195AbSDMHHa>; Sat, 13 Apr 2002 03:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314196AbSDMHH3>; Sat, 13 Apr 2002 03:07:29 -0400
Received: from angband.namesys.com ([212.16.7.85]:25986 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S314195AbSDMHH3>; Sat, 13 Apr 2002 03:07:29 -0400
Date: Sat, 13 Apr 2002 11:07:20 +0400
From: Oleg Drokin <green@namesys.com>
To: ted@psyber.com, linux-kernel@vger.kernel.org,
        Hans Reiser <reiser@namesys.com>
Subject: Re: New IDE code and DMA failures
Message-ID: <20020413110720.D13684@namesys.com>
In-Reply-To: <200204111236.g3BCaMX10247@Port.imtp.ilyichevsk.odessa.ua> <20020411130544.GA8163@dondra.ofc.psyber.com> <20020411181027.A1870@namesys.com> <20020413005805.GA17025@dondra.ofc.psyber.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Fri, Apr 12, 2002 at 05:58:05PM -0700, Ted Deppner wrote:
> > We are interested in such a damaged partitions that makes current reiserfsck
> > to segfault or to incorrectly repair FS (incorrectly in the meaning that
> > subsequent reiserfsck run finds more errors)
> > Is this the case with you?
> Subsequent runs of reiserfsck are no longer finding new errors.  There
> were several cases where --rebuild-tree segfaulted reiserfsck -- HOWEVER
> this was before I got the DMA errors ironed out.

Still reiserfsck should not segfault.
What version of reiserfsprogs do you have?
Have you saved core files?

Bye,
    Oleg
