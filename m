Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136247AbRD0WQq>; Fri, 27 Apr 2001 18:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136248AbRD0WQh>; Fri, 27 Apr 2001 18:16:37 -0400
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:8464
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S136247AbRD0WQY>; Fri, 27 Apr 2001 18:16:24 -0400
Date: Fri, 27 Apr 2001 18:22:28 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: Xavier Bestel <xavier.bestel@free.fr>,
        Goswin Brederlow <goswin.brederlow@student.uni-tuebingen.de>,
        William T Wilson <fluffy@snurgle.org>, Matt_Domsch@Dell.com,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4 and 2GB swap partition limit
Message-ID: <20010427182228.D9778@animx.eu.org>
In-Reply-To: <988368729.1406.2.camel@nomade> <200104271113.NAA16761@cave.bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <200104271113.NAA16761@cave.bitwizard.nl>; from Rogier Wolff on Fri, Apr 27, 2001 at 01:13:39PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've always been trying to convice people that 2x RAM remains a good 
> rule-of-thumb.

IMO this is pointless

             total       used       free     shared    buffers     cached
Mem:        517456     505332      12124     111016      97752     236884
-/+ buffers/cache:     170696     346760
Swap:       131048      23216     107832

Of course for me, I'm not about to waste 1gb of disk space for swap.

The swap I have is 2 partitions, one on each drive both with a priority of
0.  Personally, I like the way it's done on my box.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
