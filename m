Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276361AbRKFVAz>; Tue, 6 Nov 2001 16:00:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275734AbRKFVAp>; Tue, 6 Nov 2001 16:00:45 -0500
Received: from uunet-107.finestra.net ([65.193.229.107]:54349 "EHLO
	bianko.finestra.net") by vger.kernel.org with ESMTP
	id <S280570AbRKFVA3>; Tue, 6 Nov 2001 16:00:29 -0500
Date: Tue, 6 Nov 2001 13:00:23 -0800 (PST)
From: "Ivan F. Poddubny" <ivan@finestra.net>
To: <linux-kernel@vger.kernel.org>
Subject: stupid problem with aic-7892b
Message-ID: <Pine.LNX.4.33.0111061253350.8584-100000@bastardo-asp.finestra.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I'm running into pretty stupid problem with aic-7892b chipset at my new
dell system. When I'm trying to install RH 6.2 to this machine (dell
precision 530/2xP-4-1.5GHz/36GB scsi/512MB RAM) installer goes to south
with poblem about getting comps file. Unfortunately, this is not problem
with comps file, the roots of problem located in *probably* bad driver for
aic-7892b at installation kernel.

Another problem on this PC with installation of RH 7.0 -- it's installing
normally, but after reboot it's falling to loop with scsi initialization.

Any ideas/suggestions/points?

	--ivan

