Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311258AbSCLUKG>; Tue, 12 Mar 2002 15:10:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311331AbSCLUJ5>; Tue, 12 Mar 2002 15:09:57 -0500
Received: from dhcp065-024-127-026.columbus.rr.com ([65.24.127.26]:64776 "EHLO
	nineveh.rivenstone.net") by vger.kernel.org with ESMTP
	id <S311258AbSCLUJu>; Tue, 12 Mar 2002 15:09:50 -0500
Date: Tue, 12 Mar 2002 15:09:48 -0500
To: linux-kernel@vger.kernel.org
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] DMI patch for broken Dell laptop
Message-ID: <20020312200948.GA32040@rivenstone.net>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20020312100225.2415c8c6.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020312100225.2415c8c6.sfr@canb.auug.org.au>
User-Agent: Mutt/1.3.27i
From: jhf@rivenstone.net (Joseph Fannin)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2002 at 10:02:25AM +1100, Stephen Rothwell wrote:
> Hi Marcelo, Linus,
> 
> This adds DMI recognition for anohter broken Dell laptop BIOS (BIOS
> version A12 on the Insiron 2500).
> 

  I think this problem exists for all i2500 BIOS versions > A06. (I
have such a machine, and access to the BIOS versions back to A08 if
there is something specific I can test for -- that APM power status
worked with revision A06 is just heresay.)

-- 
Joseph Fannin
jhf@rivenstone.net

"I think I said something eloquent, like 'Fuck.'" -- Rusty Russell.
