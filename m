Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133071AbRDVABX>; Sat, 21 Apr 2001 20:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133072AbRDVABN>; Sat, 21 Apr 2001 20:01:13 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:55053 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S133071AbRDVAA5>; Sat, 21 Apr 2001 20:00:57 -0400
Subject: Re: Request for comment -- a better attribution system
To: esr@thyrsus.com
Date: Sun, 22 Apr 2001 01:02:44 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org (CML2),
        kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010421194706.A14896@thyrsus.com> from "Eric S. Raymond" at Apr 21, 2001 07:47:06 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14r7Kw-0004dU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Alan, if MAINTAINERS scaled perfectly I wouldn't have had to spend three months
> just trying to figure out who was reponsible for each of the [Cc]onfig.in
> files.  And even with that amount of effort mostly failing.

99.9999% of problems don't involve querying the set of maintainers of
Confg.in files. The system is optimised to the general case of queries people
need to make. It also happens to be accessible to people who are not
kernel gurus because it uses roughly English terms for the maintainership
and area.

The .0001% case isnt interesting. Thats the difference between real world 
systems and theory.

