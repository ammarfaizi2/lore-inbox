Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261739AbULUMik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261739AbULUMik (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 07:38:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261745AbULUMik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 07:38:40 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:32736 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261739AbULUMig (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 07:38:36 -0500
Date: Tue, 21 Dec 2004 13:38:32 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: linux lover <linux.lover2004@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: loading modules at kernel startup
In-Reply-To: <72c6e3790412210114650e05d1@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0412211338140.30255@yvahk01.tjqt.qr>
References: <72c6e3790412210114650e05d1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi all,
>                  How to load own kernel modules just after eth0
>interface is brought up?

Possibly by loading them beforehand.

>I want to load kernel module as soon as networking part of kenrel
>starts. I dont want to loose any packets that travels on my linux
>machine.


Jan Engelhardt
-- 
ENOSPC
