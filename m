Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262323AbTJNMOu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 08:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262336AbTJNMOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 08:14:50 -0400
Received: from kde.informatik.uni-kl.de ([131.246.103.200]:33472 "EHLO
	dot.kde.org") by vger.kernel.org with ESMTP id S262323AbTJNMOs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 08:14:48 -0400
Date: Tue, 14 Oct 2003 13:53:42 +0200 (CEST)
From: Bernhard Rosenkraenzer <bero@arklinux.org>
X-X-Sender: bero@dot.kde.org
To: "O.Sezer" <sezero@superonline.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23-pre7-pac1
In-Reply-To: <3F8A9A5F.8060300@superonline.com>
Message-ID: <Pine.LNX.4.56.0310141352330.3892@dot.kde.org>
References: <3F8A9A5F.8060300@superonline.com>
X-Legal-Notice: We do not accept spam. Violations will be prosecuted.
X-Subliminal-Message: Upgrade your system to Ark Linux today! http://www.arklinux.org/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Oct 2003, O.Sezer wrote:

> What is the point of this hunk?
>
> +   bool '  ATI IGP chipset support' CONFIG_AGP_ATI

A pure oversight, fixed in -pac2

> OTOH, CONFIG_DRM_GAMMA, CONFIG_DRM_S3 and CONFIG_DRM_VIA are not
> present, while they were available in 22-ac4.

They were available, but didn't work -- I've re-added them to the 
Config.in file for people who want to play with it.

LLaP
bero

-- 
Ark Linux - Linux for the masses
http://www.arklinux.org/

Redistribution and processing of this message is subject to
http://www.arklinux.org/terms.php
