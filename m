Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264411AbUEMTEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264411AbUEMTEv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 15:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264412AbUEMTEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 15:04:51 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:19847 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S264411AbUEMTEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 15:04:50 -0400
Date: Thu, 13 May 2004 12:04:40 -0700
From: Chris Wedgwood <cw@f00f.org>
To: raven@themaw.net
Cc: John McCutchan <ttb@tentacle.dhs.org>, linux-kernel@vger.kernel.org,
       nautilus-list@gnome.org
Subject: Re: [RFC/PATCH] inotify -- a dnotify replacement
Message-ID: <20040513190440.GA23111@taniwha.stupidest.org>
References: <1084152941.22837.21.camel@vertex> <Pine.LNX.4.58.0405132330480.13693@donald.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0405132330480.13693@donald.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2004 at 11:36:38PM +0800, raven@themaw.net wrote:

> Would this allow me to receive a notification when a directory is
> passed over during a path walk?

No.  And are you sure you want this?

> Could this strategy be adapted to notify an in kernel module?

Maybe you should explain what you are trying to do...  getting a
notification when a path element is walked sounds problematic of many
levels.


  --cw
