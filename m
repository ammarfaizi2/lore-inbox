Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310666AbSCMPac>; Wed, 13 Mar 2002 10:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310663AbSCMPaW>; Wed, 13 Mar 2002 10:30:22 -0500
Received: from 213-98-126-44.uc.nombres.ttd.es ([213.98.126.44]:58008 "HELO
	mitica.trasno.org") by vger.kernel.org with SMTP id <S310660AbSCMPaM>;
	Wed, 13 Mar 2002 10:30:12 -0500
To: Sandino Araico =?iso-8859-1?q?S=E1nchez?= <sandino@sandino.net>
Cc: Greg KH <greg@kroah.com>, Richard Gooch <rgooch@ras.ucalgary.ca>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.17,2.4.18 ide-scsi+usb-storage+devfs Oops
In-Reply-To: <3C7EA7CB.C36D0211@sandino.net> <20020302075847.GE20536@kroah.com>
	<3C84294C.AE1E8CE9@sandino.net>
	<200203060528.g265Sh502430@vindaloo.ras.ucalgary.ca>
	<20020306053355.GA13072@kroah.com>
	<200203060545.g265jwL02756@vindaloo.ras.ucalgary.ca>
	<20020306181956.GC16003@kroah.com> <3C868302.31C7BBC4@sandino.net>
X-Url: http://www.lfcia.org/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <3C868302.31C7BBC4@sandino.net>
Date: 13 Mar 2002 16:27:32 +0100
Message-ID: <m2ofhsij2z.fsf@trasno.mitica>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "sandino" == Sandino Araico Sánchez <sandino@sandino.net> writes:

sandino> I had to copy the Oops trace by hand to a paper. Gpm is not working correctly
sandino> on my machine. Is there another way to send the Oops trace to a file?


dmesg > file

normally works.

Later, Juan.


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
