Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288007AbSABXZy>; Wed, 2 Jan 2002 18:25:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287986AbSABXYK>; Wed, 2 Jan 2002 18:24:10 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:10116
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S287972AbSABXWy>; Wed, 2 Jan 2002 18:22:54 -0500
Date: Wed, 2 Jan 2002 18:09:26 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dave Jones <davej@suse.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
Message-ID: <20020102180926.B21788@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Jones <davej@suse.de>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020102173419.A21165@thyrsus.com> <E16LuW5-0005w3-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16LuW5-0005w3-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Jan 02, 2002 at 11:09:49PM +0000
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk>:
> Of course it isnt. cat /proc/dmi executes kernel mode code which is totally
> priviledged. /sbin/dmidecode executes slightly priviledged code which will
> core dump not crash the box if it misparses the mapped table.

You're thinking inside-out again.  Sigh...user privileges. *User* privileges! 
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

.. a government and its agents are under no general duty to 
provide public services, such as police protection, to any 
particular individual citizen...
        -- Warren v. District of Columbia, 444 A.2d 1 (D.C. App.181)
