Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270447AbRHHK4O>; Wed, 8 Aug 2001 06:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270449AbRHHK4E>; Wed, 8 Aug 2001 06:56:04 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:41991 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270447AbRHHKzr>; Wed, 8 Aug 2001 06:55:47 -0400
Subject: Re: 2.4.7-ac4 disk thrashing
To: Dieter.Nuetzel@hamburg.de (Dieter =?iso-8859-1?q?N=FCtzel?=)
Date: Wed, 8 Aug 2001 11:57:55 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel List),
        reiserfs-list@namesys.com (ReiserFS List),
        mason@suse.com (Chris Mason), NikitaDanilov@Yahoo.COM (Nikita Danilov),
        phillips@bonn-fries.net (Daniel Phillips), tmv5@home.com (Tom Vier)
In-Reply-To: <20010808063914Z270354-28344+2861@vger.kernel.org> from "Dieter =?iso-8859-1?q?N=FCtzel?=" at Aug 08, 2001 08:38:16 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15UR2B-00051d-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Could it be that the ReiserFS cleanups in ac4 do harm?
> http://marc.theaimsgroup.com/?l=3Dreiserfs&m=3D99683332027428&w=3D2

I suspect the use once patch is the more relevant one. 
