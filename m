Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262315AbUKQN6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262315AbUKQN6R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 08:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262323AbUKQN6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 08:58:17 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:29080 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262315AbUKQN6P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 08:58:15 -0500
Date: Wed, 17 Nov 2004 14:58:12 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Nico Schottelius <nico-kernel@schottelius.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Merging devfs to udev
In-Reply-To: <20041117113123.GE2282@schottelius.org>
Message-ID: <Pine.LNX.4.53.0411171457500.31693@yvahk01.tjqt.qr>
References: <20041117113123.GE2282@schottelius.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Is there a howto available to merge devfs systems to udev?
>
>I just accomplished this task and wanted to ask whether there
>is a need to for that.

What do you mean by merge? Disable devfs-fs, devfsd and switching to udev? (So,
mostly the userspace part?)


Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
