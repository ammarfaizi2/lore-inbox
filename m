Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266519AbUJRNxd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266519AbUJRNxd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 09:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266561AbUJRNxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 09:53:32 -0400
Received: from chiark.greenend.org.uk ([193.201.200.170]:65443 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S266519AbUJRNxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 09:53:23 -0400
To: root@chaos.analogic.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fw: signed kernel modules?
In-Reply-To: <Pine.LNX.4.61.0410180845040.3512@chaos.analogic.com>
References: <27277.1097702318@redhat.com> <Pine.LNX.4.61.0410150723180.8573@chaos.analogic.com> <1097843492.29988.6.camel@weaponx.rchland.ibm.com> <200410151153.08527.gene.heskett@verizon.net> <1097857049.29988.29.camel@weaponx.rchland.ibm.com> <Pine.LNX.4.61.0410151237360.6239@chaos.analogic.com> <1097860121.13633.358.camel@hades.cambridge.redhat.com> <Pine.LNX.4.61.0410151319460.6877@chaos.analogic.com> <1097873791.5119.10.camel@krustophenia.net> <20041015211809.GA27783@kroah.com> <4170426E.5070108@nortelnetworks.com> <Pine.LNX.4.61.0410151744220.3651@chaos.analogic.com> <Pine.LNX.4.61.0410151744220.3651@chaos.analogic.com> <Pine.LNX.4.61.0410180845040.3512@chaos.analogic.com>
Date: Mon, 18 Oct 2004 14:53:21 +0100
Message-Id: <E1CJXww-0006F4-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson <root@chaos.analogic.com> wrote:

> If the whole module license issue is truly one of being able
> to review the source, then certainly nobody would fear the
> inclusion of a "PUBLIC" license string. This would fit the
> broad classification of publicly-available sources, not
> necessarily just in the "Public domain". For instance, when
> a company puts the sources for some driver on it's Web Page,
> but doesn't want to have anything to do with Mr. Stallman.

This potentially leds to arguments about whether developers who have
seen your publically available code are then tainted. If you don't want
anything to do with Mr. Stallman, why not just use a BSD-style license?

-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
