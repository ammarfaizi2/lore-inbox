Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265356AbRF0SbY>; Wed, 27 Jun 2001 14:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265354AbRF0SbO>; Wed, 27 Jun 2001 14:31:14 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:30725 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265350AbRF0SbD>; Wed, 27 Jun 2001 14:31:03 -0400
Subject: Re: mixer    (was: eye candy)
To: ben@kalifornia.com (Ben Ford)
Date: Wed, 27 Jun 2001 19:27:36 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, progeny-debian@lists.progeny.com
In-Reply-To: <3B3A23C5.6070601@kalifornia.com> from "Ben Ford" at Jun 27, 2001 11:19:49 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15FK2K-0005cq-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Are you sure of that?  I have another box that works fine, including 
> gmix.  However, cat /dev/sndstat give me the no such device error.

/dev/sndstat is legacy item. Its going away soon and its incomplete now
