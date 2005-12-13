Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932294AbVLNKWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbVLNKWn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 05:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932283AbVLNKWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 05:22:43 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:8100 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932276AbVLNKWm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 05:22:42 -0500
Subject: Re: tp_smapi conflict with IDE, hdaps
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Shem Multinymous <multinymous@gmail.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, Rovert Love <rlove@rlove.org>,
       Jens Axboe <axboe@suse.de>, linux-ide@vger.kernel.org
In-Reply-To: <41840b750512131041i5ae5f021h29eed3492bad88ca@mail.gmail.com>
References: <41840b750512130635p45591633ya1df731f24a87658@mail.gmail.com>
	 <1134486203.11732.60.camel@localhost.localdomain>
	 <41840b750512130729y49903791xc9ceba4e6a18322e@mail.gmail.com>
	 <41840b750512131041i5ae5f021h29eed3492bad88ca@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 13 Dec 2005 19:18:24 +0000
Message-Id: <1134501504.11732.120.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-12-13 at 20:41 +0200, Shem Multinymous wrote:
> Meanwhile, I found out that with this drive, "hdparm -E" does affect
> CD-R discs

That is expected behaviour. DVD speed is controlled by different
interfaces

