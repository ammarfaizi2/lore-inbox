Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272165AbRIENCt>; Wed, 5 Sep 2001 09:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272168AbRIENCj>; Wed, 5 Sep 2001 09:02:39 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:60932 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272165AbRIENC0>; Wed, 5 Sep 2001 09:02:26 -0400
Subject: Re: Linux 2.4.9-ac6
To: christophe.barbe@lineo.fr (christophe =?iso-8859-1?Q?barb=E9?=)
Date: Wed, 5 Sep 2001 14:06:36 +0100 (BST)
Cc: davids@webmaster.com (David Schwartz), linux-kernel@vger.kernel.org
In-Reply-To: <20010905145039.A10655@pc8.lineo.fr> from "christophe =?iso-8859-1?Q?barb=E9?=" at Sep 05, 2001 02:50:39 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ecO4-0005rR-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Would it not be possible with your scheme to package a closed source dr=
> iver
> in an open source wrapper driver and then defeat your tainting techniqu=
> e.
> 
> Is it legally possible to copyright a kind of magic number with a copyr=
> ight
> allowing only it's used in open & public source driver ?

Oh you can certainly defeat it. That doesn't actually bother me. Firstly
nobody at Nvidia and friends is trying to mislead us, its their end users
who are. Secondly your average corporate lawyers get upset about putting
in license tags that are not true in case a court holds them to the tags,
and thirdly since its arguably digital rights management they might face
five years in jail in the USA for doing so 8)

Alan
