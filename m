Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291593AbSBHPI4>; Fri, 8 Feb 2002 10:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291599AbSBHPIn>; Fri, 8 Feb 2002 10:08:43 -0500
Received: from ns.suse.de ([213.95.15.193]:9489 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S291593AbSBHPIh>;
	Fri, 8 Feb 2002 10:08:37 -0500
Date: Fri, 8 Feb 2002 16:08:35 +0100
From: Dave Jones <davej@suse.de>
To: Wichert Akkerman <wichert@cistron.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide cleanup
Message-ID: <20020208160835.G32413@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Wichert Akkerman <wichert@cistron.nl>, linux-kernel@vger.kernel.org
In-Reply-To: <20020206205332.GA3217@elf.ucw.cz> <3C63C5EF.4050403@evision-ventures.com> <20020208133755.A10250@suse.cz> <3C63CF54.9090308@evision-ventures.com> <a40okb$mds$1@picard.cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <a40okb$mds$1@picard.cistron.nl>; from wichert@cistron.nl on Fri, Feb 08, 2002 at 03:50:51PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2002 at 03:50:51PM +0100, Wichert Akkerman wrote:

 > Why, I don't see that. Everyone should use whatever notation he/she
 > feels most comfortable with.

 Documentation/CodingStyle is there for a reason.
 Having code in readable form only to its author isn't good practise.
 (Unfortunatly, drivers/ide/ isn't by far the worse offender..)

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
