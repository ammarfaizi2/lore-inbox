Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261314AbVALTV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbVALTV1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 14:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbVALTUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 14:20:32 -0500
Received: from scrat.hensema.net ([62.212.82.150]:21402 "EHLO
	scrat.hensema.net") by vger.kernel.org with ESMTP id S261338AbVALTPt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 14:15:49 -0500
From: Erik Hensema <erik@hensema.net>
Subject: Re: [fuse-devel] Merging?
Date: Wed, 12 Jan 2005 19:15:44 +0000 (UTC)
Message-ID: <slrncuatr0.ego.erik@bender.home.hensema.net>
References: <loom.20041231T155940-548@post.gmane.org> <E1ClQi2-0004BO-00@dorka.pomaz.szeredi.hu> <E1CoisR-0001Hi-00@dorka.pomaz.szeredi.hu> <20050112110109.6a21fae5.akpm@osdl.org>
Reply-To: erik@hensema.net
User-Agent: slrn/0.9.8.0 (Linux)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton (akpm@osdl.org) wrote:
> Miklos Szeredi <miklos@szeredi.hu> wrote:
>>
>>  Well, there doesn't seem to be a great rush to include FUSE in the
>>  kernel.  Maybe they just don't realize what they are missing out on ;)
>
> heh.  What userspace filesystems have thus-far been developed, and what are
> people using them for?

I was using siefs, to mount the fs of my Siemens mobile phone
(via serial cable). However it doesn't seem to work with the
current fuse anymore.

-- 
Erik Hensema <erik@hensema.net>
