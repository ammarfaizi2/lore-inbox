Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131181AbRAEMz1>; Fri, 5 Jan 2001 07:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131283AbRAEMzQ>; Fri, 5 Jan 2001 07:55:16 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:9989 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131180AbRAEMzL>; Fri, 5 Jan 2001 07:55:11 -0500
Subject: Re: Update of quota patches
To: jack@suse.cz (Jan Kara)
Date: Fri, 5 Jan 2001 12:57:00 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, flx@msu.ru, alan@redhat.com
In-Reply-To: <20010105133045.A30949@atrey.karlin.mff.cuni.cz> from "Jan Kara" at Jan 05, 2001 01:30:45 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14EWQY-0007ch-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> and added a few comments. I also fixed compilation problems
> (when quota was disabled) - Alan, were there any problems
> I didn't fix (I've seen you and someone else were fixing some

AFAIK the only reported problem was the compile with no quotas
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
