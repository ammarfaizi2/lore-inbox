Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292388AbSBPPVM>; Sat, 16 Feb 2002 10:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292385AbSBPPVD>; Sat, 16 Feb 2002 10:21:03 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:2312
	"EHLO golux.thyrsus.com") by vger.kernel.org with ESMTP
	id <S292388AbSBPPU1>; Sat, 16 Feb 2002 10:20:27 -0500
Date: Sat, 16 Feb 2002 09:53:45 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Dave Jones <davej@suse.de>, Larry McVoy <lm@work.bitmover.com>,
        Arjan van de Ven <arjan@pc1-camc5-0-cust78.cam.cable.ntl.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Disgusted with kbuild developers
Message-ID: <20020216095345.N23546@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Jeff Garzik <jgarzik@mandrakesoft.com>, Dave Jones <davej@suse.de>,
	Larry McVoy <lm@work.bitmover.com>,
	Arjan van de Ven <arjan@pc1-camc5-0-cust78.cam.cable.ntl.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020215135557.B10961@thyrsus.com> <200202151929.g1FJTaU03362@pc1-camc5-0-cust78.cam.cable.ntl.com> <20020215141433.B11369@thyrsus.com> <20020215195818.A3534@pc1-camc5-0-cust78.cam.cable.ntl.com> <20020215145421.A12540@thyrsus.com> <20020215124255.F28735@work.bitmover.com> <20020215153953.D12540@thyrsus.com> <20020215221532.K27880@suse.de> <20020215155817.A14083@thyrsus.com> <3C6E1942.C08DA061@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C6E1942.C08DA061@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Sat, Feb 16, 2002 at 03:33:06AM -0500
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@mandrakesoft.com>:
> How hard is it to maintain a database where the key for each entry is
> easy an unambigious?

It's not that simple, either.  You have to track the symbols that are
*supposed* to be different between trees.  The devil is in the details --
and it's a big devil.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>
