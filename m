Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317919AbSFNOQ3>; Fri, 14 Jun 2002 10:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317920AbSFNOQ2>; Fri, 14 Jun 2002 10:16:28 -0400
Received: from ns.suse.de ([213.95.15.193]:55051 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317919AbSFNOQ0>;
	Fri, 14 Jun 2002 10:16:26 -0400
Date: Fri, 14 Jun 2002 16:16:27 +0200
From: Dave Jones <davej@suse.de>
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH: NEW SUBARCHITECTURE FOR 2.5.21] support for NCR voyager (3/4/5xxx series)
Message-ID: <20020614161627.O16772@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <davej@suse.de> <200206140013.g5E0DQR25561@localhost.localdomain> <20020614024547.H16772@suse.de> <20020614134152.GA1293@pazke.ipt> <20020614154945.M16772@suse.de> <20020614135229.GA313@pazke.ipt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2002 at 05:52:29PM +0400, Andrey Panin wrote:

 > >  > "Latest" (2.4.17) visws patch which i'm planning to convert for 2.5, uses
 > >  > function MP_processor_info() from generic mpparse.c. May be it makes sence
 > >  > to move to some generic file ?
 > > Is that the one from the visws sourceforge project ?
 > Yes it is.

Ah good. *cross item off TODO list*

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
