Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262898AbVCDPsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262898AbVCDPsV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 10:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262906AbVCDPsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 10:48:21 -0500
Received: from smtp-out.hotpop.com ([38.113.3.61]:30903 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S262898AbVCDPsO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 10:48:14 -0500
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: linux-fbdev-devel@lists.sourceforge.net, Adrian Bunk <bunk@stusta.de>,
       Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [Linux-fbdev-devel] [2.6 patch] drivers/video/: more cleanups
Date: Fri, 4 Mar 2005 23:47:01 +0800
User-Agent: KMail/1.5.4
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20050303210119.GK4608@stusta.de> <9e47339105030314442a2b4e43@mail.gmail.com> <20050304113719.GE3992@stusta.de>
In-Reply-To: <20050304113719.GE3992@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503042347.01309.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 March 2005 19:37, Adrian Bunk wrote:
> On Thu, Mar 03, 2005 at 05:44:30PM -0500, Jon Smirl wrote:
> > On Thu, 3 Mar 2005 22:01:19 +0100, Adrian Bunk <bunk@stusta.de> wrote:
> > > This patch contains cleanups including the following:
> >
> > Are you cleaning up all of that annoying trailing whitespace too? It
> > is always giving me problems on diffs.
>
> I'm not the maintainer, and such a cleanup might break all pending
> patches.
>
> Antonino, any opinions on such cleanups?

Just whitespace cleanup, no.  However, they can be piggy-backed on other
patches, but only on the sections affected.

Tony


