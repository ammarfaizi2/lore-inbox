Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132500AbRD1NbS>; Sat, 28 Apr 2001 09:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132479AbRD1NbI>; Sat, 28 Apr 2001 09:31:08 -0400
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:33296
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S132562AbRD1Nay>; Sat, 28 Apr 2001 09:30:54 -0400
Date: Sat, 28 Apr 2001 09:37:22 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: Xavier Bestel <xavier.bestel@free.fr>,
        Goswin Brederlow <goswin.brederlow@student.uni-tuebingen.de>,
        William T Wilson <fluffy@snurgle.org>, Matt_Domsch@Dell.com,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4 and 2GB swap partition limit
Message-ID: <20010428093722.A17218@animx.eu.org>
In-Reply-To: <20010427182228.D9778@animx.eu.org> <200104281317.PAA04172@cave.bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <200104281317.PAA04172@cave.bitwizard.nl>; from Rogier Wolff on Sat, Apr 28, 2001 at 03:17:01PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So you've spent almost $200 for RAM, and refuse to spend $4 for 1Gb of
> swap space. Fine with me. 

I put this much ram into the system to keep from having swap.  I still say
swap=2x ram is a stupid idea.  I fail to see the logic in that.  Disk is
much much slower than ram and if you're writing all ram to disk that's also
slow.

I have a machine with 256mb of ram and no disk.  It runs just fine w/o swap. 
Only reason I even had swap here is if I ran something that used up all my
memory and it has happened.

Since when has linux started to be like windows "our way or no way"?

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
