Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261493AbRETMdk>; Sun, 20 May 2001 08:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261859AbRETMda>; Sun, 20 May 2001 08:33:30 -0400
Received: from hera.cwi.nl ([192.16.191.8]:16571 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S261493AbRETMdQ>;
	Sun, 20 May 2001 08:33:16 -0400
Date: Sun, 20 May 2001 14:32:10 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200105201232.OAA55488.aeb@vlet.cwi.nl>
To: abramo@alsa-project.org, viro@math.psu.edu
Subject: Re: no ioctls for serial ports? [was Re: LANANA: To Pending DeviceNumberRegistrants]
Cc: alan@lxorguk.ukuu.org.uk, hpa@transmeta.com, jgarzik@mandrakesoft.com,
        jsimmons@transvirtual.com, linux-kernel@vger.kernel.org,
        neilb@cse.unsw.edu.au, pavel@suse.cz, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Getting a list of all ioctls in the tree, along with types of their arguments
> would be a great start. Anyone willing to help with that?

% man 2 ioctl_list

gives a very outdated list. Collecting the present list is trivial
but time-consuming. If anyone does I would be happy if he also
sent me an updated ioctl_list.2

Andries

[PS I released man-pages-1.36 a few days ago]
