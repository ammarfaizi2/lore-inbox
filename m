Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129047AbQKOC07>; Tue, 14 Nov 2000 21:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129157AbQKOC0u>; Tue, 14 Nov 2000 21:26:50 -0500
Received: from [63.95.87.168] ([63.95.87.168]:35339 "HELO xi.linuxpower.cx")
	by vger.kernel.org with SMTP id <S129047AbQKOC0b>;
	Tue, 14 Nov 2000 21:26:31 -0500
Date: Tue, 14 Nov 2000 20:56:29 -0500
From: Gregory Maxwell <greg@linuxpower.cx>
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>, linux-kernel@vger.kernel.org,
        linware@sh.cvut.cz
Subject: Re: NetWare Changing IP Port 524
Message-ID: <20001114205629.B5133@xi.linuxpower.cx>
In-Reply-To: <CDB246E6CB3@vcnet.vc.cvut.cz> <3A11A0AB.92B1109D@timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.8i
In-Reply-To: <3A11A0AB.92B1109D@timpanogas.org>; from jmerkey@timpanogas.org on Tue, Nov 14, 2000 at 01:29:31PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2000 at 01:29:31PM -0700, Jeff V. Merkey wrote:
> Hopefully, sanity will rule out here.  I information being leaked from
> what I reviewed was the ability for a hacker to exploit port 524 and use
> it
> to obtain a local copy of the entire routing table for other IP servers
> INSIDE an organization (which is a huge hole). 

That is obviously the hole as it is clearly not the intended function of the
service. However, anyone who depends on the secrecy of their IP routing
tables or overall network topology for security has bigger problems then
some stupid Netware bug.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
