Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133097AbRDVSyS>; Sun, 22 Apr 2001 14:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135248AbRDVSyI>; Sun, 22 Apr 2001 14:54:08 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:10769 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S133097AbRDVSx5>; Sun, 22 Apr 2001 14:53:57 -0400
Subject: Re: 2.4.3+ sound distortion
To: v.p.p.julien@xs4all.nl (Victor Julien)
Date: Sun, 22 Apr 2001 19:55:07 +0100 (BST)
Cc: manuel@mclure.org (Manuel McLure), linux-kernel@vger.kernel.org
In-Reply-To: <20010422203738.A449@victor> from "Victor Julien" at Apr 22, 2001 08:37:38 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14rP0p-0006Mu-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Wow! Now it not only boots right, the sound distortion problem also seems
> to be fixed!!! Great work! However another problem is still here, i see
> only one of the two ide-channels of the PDC20265.

There is a possible patch for that in the Red Hat source rpm but its a bit
ugly. I need to figure out if it can be cleaned up and get it included into
the main tree


