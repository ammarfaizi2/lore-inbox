Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264541AbUDVSK6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264541AbUDVSK6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 14:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264616AbUDVSK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 14:10:57 -0400
Received: from ip213-185-37-13.laajakaista.mtv3.fi ([213.185.37.13]:28556 "EHLO
	home.holviala.com") by vger.kernel.org with ESMTP id S264541AbUDVSKy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 14:10:54 -0400
From: Kim Holviala <kim@holviala.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] psmouse: fix mouse hotplugging
Date: Thu, 22 Apr 2004 21:10:53 +0300
User-Agent: KMail/1.6.1
References: <200404221044.56294.kim@holviala.com> <20040422155307.GA14090@irc.pl>
In-Reply-To: <20040422155307.GA14090@irc.pl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404222110.53866.kim@holviala.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 April 2004 18:53, Tomasz Torcz wrote:

> > This patch fixes hotplugging of PS/2 devices on hardware which don't
> > support hotplugging of PS/2 devices. In other words, most desktop
> > machines.
>
>  Is this needed? I frequently "hotplug" my trackball when 2.6 is forgeting
> about it. Replugin make it work again, spitting in logs:

It's mostly meant for cases where you hotplug some other mouse, not the same 
one.


Kim
