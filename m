Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965111AbVINJ1s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965111AbVINJ1s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 05:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965112AbVINJ1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 05:27:48 -0400
Received: from livid.absolutedigital.net ([66.92.46.173]:35247 "EHLO
	mx2.absolutedigital.net") by vger.kernel.org with ESMTP
	id S965111AbVINJ1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 05:27:47 -0400
Date: Wed, 14 Sep 2005 05:27:49 -0400 (EDT)
From: Cal Peake <cp@absolutedigital.net>
To: Karel Kulhavy <clock@twibright.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Search in make menuconfig doesn't work properly
In-Reply-To: <20050914065010.GA8430@kestrel.twibright.com>
Message-ID: <Pine.LNX.4.61.0509140524490.4846@lancer.cnet.absolutedigital.net>
References: <20050914065010.GA8430@kestrel.twibright.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Sep 2005, Karel Kulhavy wrote:

> I have 2.6.13 and if I press '/' in make menuconfig (Search
> Configuration Parameter, Enter Keyword) and enther "emulation", it
> doesn't find
> CONFIG_BLK_DEV_IDESCSI -  SCSI emulation support.

AFAIK it only matches against the CONFIG_ symbols. If you want it to do 
more cook up a patch ;)

-- 
". . . tell 'em we use Linux." -- Dave Chappelle

