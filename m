Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265844AbSLXVCp>; Tue, 24 Dec 2002 16:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265857AbSLXVCp>; Tue, 24 Dec 2002 16:02:45 -0500
Received: from users.linvision.com ([62.58.92.114]:47575 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S265844AbSLXVCo>; Tue, 24 Dec 2002 16:02:44 -0500
Date: Tue, 24 Dec 2002 22:10:19 +0100
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>,
       Stephen Rothwell <sfr@canb.auug.org.au>,
       Petr Vandrovec <vandrove@vc.cvut.cz>, lk@tantalophile.demon.co.uk,
       Ingo Molnar <mingo@elte.hu>, drepper@redhat.com,
       bart@etpmod.phys.tue.nl, davej@codemonkey.org.uk, hpa@transmeta.com,
       terje.eggestad@scali.com, matti.aarnio@zmailer.org, hugh@veritas.com,
       linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
Message-ID: <20021224221019.A20369@bitwizard.nl>
References: <20021224090520.A19829@bitwizard.nl> <Pine.LNX.4.44.0212241049100.1230-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0212241049100.1230-100000@home.transmeta.com>
User-Agent: Mutt/1.3.22.1i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 24, 2002 at 10:51:11AM -0800, Linus Torvalds wrote:
> 
> Everything here fits in one cache-line, so clearly the cacheline issues
> don't matter.

I'm getting old. Larger cache lines, you're right. 

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* The Worlds Ecosystem is a stable system. Stable systems may experience *
* excursions from the stable situation. We are currently in such an      * 
* excursion: The stable situation does not include humans. ***************
