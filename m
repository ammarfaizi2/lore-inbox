Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135718AbRAGF35>; Sun, 7 Jan 2001 00:29:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135743AbRAGF3h>; Sun, 7 Jan 2001 00:29:37 -0500
Received: from Cantor.suse.de ([194.112.123.193]:7179 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S135718AbRAGF3a>;
	Sun, 7 Jan 2001 00:29:30 -0500
Date: Sun, 7 Jan 2001 06:29:22 +0100
From: Andi Kleen <ak@suse.de>
To: Ben Greear <greearb@candelatech.com>
Cc: jamal <hadi@cyberus.ca>, Andi Kleen <ak@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: [PATCH] hashed device lookup (Does NOT meet Linus' sumissionpolicy!)
Message-ID: <20010107062922.B15198@gruyere.muc.suse.de>
In-Reply-To: <Pine.GSO.4.30.0101062253440.18916-100000@shell.cyberus.ca> <3A580BA9.ADAA2B97@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A580BA9.ADAA2B97@candelatech.com>; from greearb@candelatech.com on Sat, Jan 06, 2001 at 11:24:41PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 06, 2001 at 11:24:41PM -0700, Ben Greear wrote:
> jamal wrote:
> > 
> 
> > Not to stray from the subject, Ben's effort is still needed. I think real
> > numbers are useful instead of claims like it "displayed faster"
> 
> A single #define near the top of the patch will turn it on/off, so
> benchmarking should be fairly easy.  Please suggest benchmarks you
> consider valid.

The only issue I know was the long delay in ifconfig.
If that's fixed I see nothing else that would be worth benchmarking. 


-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
