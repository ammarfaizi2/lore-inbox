Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288582AbSADNgb>; Fri, 4 Jan 2002 08:36:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288620AbSADNgV>; Fri, 4 Jan 2002 08:36:21 -0500
Received: from ns.caldera.de ([212.34.180.1]:55173 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S288582AbSADNgO>;
	Fri, 4 Jan 2002 08:36:14 -0500
Date: Fri, 4 Jan 2002 14:36:04 +0100
Message-Id: <200201041336.g04Da4l15036@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: esr@thyrsus.com ("Eric S. Raymond")
Cc: Erik Andersen <andersen@codepoet.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andreas Schwab <schwab@suse.de>
Subject: Re: LSB1.1: /proc/cpuinfo
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <20020104080358.A11215@thyrsus.com>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.13 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020104080358.A11215@thyrsus.com> you wrote:
> If the PPC etc. have 32-bit ints then I stand corrected, but I thought the 
> compiler ports on those machines used the native register size same as
> everybody else.

ANY Linux for to a 64bit machines use the LP64 programming model which
means that long != int.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
