Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289776AbSBOOM1>; Fri, 15 Feb 2002 09:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289802AbSBOOMR>; Fri, 15 Feb 2002 09:12:17 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:57868 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289776AbSBOOMA>; Fri, 15 Feb 2002 09:12:00 -0500
Subject: Re: oops with 2.4.18-pre9-mjc2
To: rj@open-net.org (Robert Jameson)
Date: Fri, 15 Feb 2002 14:26:01 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020215035135.0c26b130.rj@open-net.org> from "Robert Jameson" at Feb 15, 2002 03:51:35 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16bjJJ-0003Ig-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have been seeing this oops from 2.4.16 -> 2.4.18-pre9, so here we go!
> 
> Reading Oops report from the terminal
> CPU:    0
> EIP:    0010:[<dc838114>]    Tainted: P 
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

What strange modules do you have loaded ?

If its a binary only one I'd like to know. If its just the base kernel I'd
appreciate an lsmod so I can find which module is missing a license tag
