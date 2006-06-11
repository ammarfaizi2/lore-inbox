Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbWFKKoa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbWFKKoa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 06:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbWFKKoa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 06:44:30 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:1472 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750788AbWFKKoa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 06:44:30 -0400
Date: Sun, 11 Jun 2006 12:43:55 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Anne Thrax <foobarfoobarfoobar@gmail.com>
cc: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: Removal of security/root_plug.c
In-Reply-To: <448B5449.2030605@gmail.com>
Message-ID: <Pine.LNX.4.61.0606111243350.13585@yvahk01.tjqt.qr>
References: <448B5449.2030605@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hello all,
>
>Apparently security/root_plug.c was written for a Linux Journal article,
>and while it does do a good job of explaining LSM, I don't see much use for
>it in the mainstream kernel. I suggest that it be removed, because I don't
>think that it serves much purpose. I doubt that anyone actually uses this,
>for if they did, I think that it would be modified and have many additions.
>Even the author states that it is just a starting point. Maybe the article
>(if Linux Journal is okay with it) along with the code should be moved to
>Documentation/?
>
At least it should be kept in the new DDK Greg released, if it is going to 
be removed from mainline.


Jan Engelhardt
-- 
