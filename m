Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262934AbREaAi5>; Wed, 30 May 2001 20:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262935AbREaAii>; Wed, 30 May 2001 20:38:38 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53261 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262934AbREaAi3>;
	Wed, 30 May 2001 20:38:29 -0400
Date: Thu, 31 May 2001 01:38:27 +0100
From: Joel Becker <jlbec@evilplan.org>
To: Jonathan Lundell <jlundell@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to know HZ from userspace?
Message-ID: <20010531013827.J16761@parcelfarce.linux.theplanet.co.uk>
Mail-Followup-To: Joel Becker <jlbec@evilplan.org>,
	Jonathan Lundell <jlundell@pobox.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20010530203725.H27719@corellia.laforge.distro.conectiva> <9f41vq$our$1@cesium.transmeta.com> <p05100316b73b3f2e80e2@[10.128.7.49]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <p05100316b73b3f2e80e2@[10.128.7.49]>; from jlundell@pobox.com on Wed, May 30, 2001 at 05:24:37PM -0700
X-Burt-Line: Trees are cool.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2001 at 05:24:37PM -0700, Jonathan Lundell wrote:
> FWIW (perhaps not much in this context), the POSIX way is sysconf(_SC_CLK_TCK)
> 
> POSIX sysconf is pretty useful for this kind of thing (not just HZ, either).

	Well, how many hundred things on Linux are available from /proc
but not from sysconf or the like?  :-)

Joel

-- 

"There is no sincerer love than the love of food."  
         - George Bernard Shaw 

			http://www.jlbec.org/
			jlbec@evilplan.org
