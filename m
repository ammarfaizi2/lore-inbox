Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265610AbUBBPPX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 10:15:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265635AbUBBPPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 10:15:23 -0500
Received: from lightning.hereintown.net ([141.157.132.3]:44427 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id S265610AbUBBPPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 10:15:22 -0500
Subject: Re: megaraid and 2.6.1
From: Chris Meadors <clubneon@hereintown.net>
To: Dan Podeanu <kernel@ccnetwork.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <01db01c3e985$df52e5e0$33e613c2@nod.ro>
References: <01db01c3e985$df52e5e0$33e613c2@nod.ro>
Content-Type: text/plain
Message-Id: <1075734921.3609.3.camel@clubneon.priv.hereintown.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 02 Feb 2004 10:15:21 -0500
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1AnfnG-0000y0-4D*uu.grg2fcVQ*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-02-02 at 07:12, Dan Podeanu wrote:
> Hello,
> 
> Chris Meador's patch regarding megaraid PCI IDs fixup in 2.6.1-rcX didn't
> make it
> in 2.6.1 so certain megaraid devices (320-1, 320-2, presumably others
> aswell) aren't
> recognized by 2.6.1.

[patch snipped]

> Anyone knows whats the status of this problem ? Does the patch fixes it ?

The patch went into 2.4.2-rc2.  And the patch does indeed fix it, I have
a 320-0.

-- 
Chris

