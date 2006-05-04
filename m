Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964823AbWEDPRO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbWEDPRO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 11:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964820AbWEDPRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 11:17:14 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:19174 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964819AbWEDPRN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 11:17:13 -0400
Subject: Re: cdrom: a dirty CD can freeze your system
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christian Trefzer <ctrefzer@gmx.de>
Cc: Herbert Rosmanith <kernel@wildsau.enemy.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060504141402.GB8348@hermes.uziel.local>
References: <200605041232.k44CWnFn004411@wildsau.enemy.org>
	 <1146750532.20677.38.camel@localhost.localdomain>
	 <20060504141402.GB8348@hermes.uziel.local>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 04 May 2006 16:28:42 +0100
Message-Id: <1146756522.22308.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-05-04 at 16:14 +0200, Christian Trefzer wrote:
> I'd love to, but currently I'm running git kernels on both of my
> machines, and unfortunately 2.6.16-ide1 won't apply ; )

Fair enough 8)

> Since you've been busy I didn't want to bother you, but now that you
> mention your PATA efforts again, is there a git tree to pull from, which
> contains code similar to that in the latest patches?

Not for the current code. The core stuff is mostly in the tree now and
I'll try and push a patch some time today or tomorrow thats versus
2.6.17-rc and should match.

Alan

