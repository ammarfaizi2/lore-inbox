Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932397AbVKRUDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbVKRUDe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 15:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbVKRUDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 15:03:34 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:40421 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932397AbVKRUDd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 15:03:33 -0500
Subject: Re: Swap Bug Massive EXT3 Corruption on FC4 with 2.6.14 update
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: jmerkey <jmerkey@soleranetworks.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <437CC67C.4060109@soleranetworks.com>
References: <437CC67C.4060109@soleranetworks.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 18 Nov 2005 20:35:33 +0000
Message-Id: <1132346133.5238.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-11-17 at 11:05 -0700, jmerkey wrote:
> To reproduce, install FC2 on an /dev/hda device with defaults, then 
> install FC4 on a /dev/hdb device, build the 2.6.14 update for
> FC4 and watch your data disappear.

Should be reported in the FC bugzilla although I've not been able to
reproduce it.

