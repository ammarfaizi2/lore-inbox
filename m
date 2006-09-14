Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751054AbWINLRd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbWINLRd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 07:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbWINLRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 07:17:32 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:17622 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751054AbWINLRc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 07:17:32 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Robert Hancock <hancockr@shaw.ca>
Subject: Re: 2.6.18-rc6-mm2
Date: Thu, 14 Sep 2006 13:16:54 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       dbrownell@users.sourceforge.net
References: <fa.7a4Rl1qDmYu4ew2hC2NUSUy6Roo@ifi.uio.no> <4508E5AA.7000009@shaw.ca>
In-Reply-To: <4508E5AA.7000009@shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609141316.55207.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 14 September 2006 07:16, Robert Hancock wrote:
> Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc6/2.6.18-rc6-mm2/
> 
> Seeing a problem with suspend-to-RAM or suspend-to-disk on my laptop. If 
> I suspend (either way) once it is fine. If I suspend again the EHCI 
> controller fails to suspend and the suspend is aborted.

This one is being worked on now (see the thread starting from
http://marc.theaimsgroup.com/?l=linux-kernel&m=115815146907713&w=2).

Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
