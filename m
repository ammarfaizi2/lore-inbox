Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313421AbSGYNFg>; Thu, 25 Jul 2002 09:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313477AbSGYNFg>; Thu, 25 Jul 2002 09:05:36 -0400
Received: from smtp3.9tel.net ([213.203.124.146]:27581 "HELO smtp3.9tel.net")
	by vger.kernel.org with SMTP id <S313421AbSGYNFf>;
	Thu, 25 Jul 2002 09:05:35 -0400
Date: Thu, 25 Jul 2002 15:07:23 +0200 (CEST)
From: Samuel Thibault <samuel.thibault@fnac.net>
Reply-To: Samuel Thibault <samuel.thibault@fnac.net>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       vojtech@suse.cz, martin@dalecki.de
Subject: Re: [PATCH] drivers/ide/qd65xx: no cli/sti (2.4.19-pre3 & 2.5.28)
In-Reply-To: <Pine.LNX.4.10.10207241643430.4719-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.10.10207251501580.505-100000@bureau.famille.thibault.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 24 Jul 2002, Andre Hedrick wrote:

> You just dropped IO sync with the main loop, it is a dead dog.

Why sync with the main loop ?

