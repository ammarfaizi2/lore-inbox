Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263240AbREaVfd>; Thu, 31 May 2001 17:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263238AbREaVfX>; Thu, 31 May 2001 17:35:23 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:14354 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263240AbREaVfM>; Thu, 31 May 2001 17:35:12 -0400
Subject: Re: unmount issues with 2.4.5-ac5, 3ware, and ReiserFS (was: kernel-2.4.5
To: jijo@i-manila.com.ph (Federico Sevilla III)
Date: Thu, 31 May 2001 22:32:34 +0100 (BST)
Cc: reiserfs@devlinux.com (ReiserFS Mailing List),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
        alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <Pine.LNX.4.21.0106010147060.1228-100000@kalapati.jijo.local> from "Federico Sevilla III" at Jun 01, 2001 02:23:15 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E155a3W-00084H-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm staying on 2.4.5-ac5 for whatever it's worth (putting my life on the
> line for the community? kidding...) and will report anything new. I will
> be on the lookout for later ac patches, 2.4.6 ... and hopefully anything
> anybody can share with me about this. I hope we'll see an end to these

Can you tell me if 2.4.5-ac4 is ok. ac5 has a small 'obviously correct'
reiserfs module unload change that seems the first suspect

