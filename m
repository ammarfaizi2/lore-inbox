Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265339AbUGAOXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265339AbUGAOXP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 10:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265342AbUGAOXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 10:23:15 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:50095 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S265339AbUGAOXO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 10:23:14 -0400
From: Duncan Sands <baldrick@free.fr>
To: "Stephen J. Gowdy" <gowdy@slac.stanford.edu>
Subject: Re: [Linux-usb-users] linux 2.6.6, bttv and usb2 data corruption & lockups & poor performance
Date: Thu, 1 Jul 2004 16:23:09 +0200
User-Agent: KMail/1.6.2
Cc: linux-usb-users@lists.sourceforge.net, janne <sniff@xxx.ath.cx>,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.40.0407010017360.1548-100000@xxx.xxx> <200407010904.39925.baldrick@free.fr> <Pine.LNX.4.58.0407010704570.4677@antonia.sgowdy.org>
In-Reply-To: <Pine.LNX.4.58.0407010704570.4677@antonia.sgowdy.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407011623.09559.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 01 July 2004 16:06, Stephen J. Gowdy wrote:
> On Thu, 1 Jul 2004, Duncan Sands wrote:
> 
> > > First of all, usb2 throughput was disappointing, i only got about
> > > 5-15MB/s (usually about 8MB/s) while the manufacturer claims sustained
> > > datarate of 35MB/s.
> >
> > Are you sure you plugged your device into a usb 2 port, and not a usb
> > 1.1 port? Also, some products claim to be usb 2 devices, when they are
> > in fact only usb 1.1.
> 
> 1.1 devices would only get less than 1MB/s.

Ah, I misread it as 8 M bits / s, which is max 1.1 speed.

Bye, Duncan.
