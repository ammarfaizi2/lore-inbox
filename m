Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261230AbUKSBqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbUKSBqu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 20:46:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262846AbUKRSkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 13:40:47 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:4262 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262864AbUKRSgf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 13:36:35 -0500
Date: Thu, 18 Nov 2004 19:36:21 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Andrew Morton <akpm@osdl.org>, "John W. Linville" <linville@tuxdriver.com>,
       linux-kernel@vger.kernel.org, alan@redhat.com
Subject: Re: [patch 2.6.10-rc2] oss: AC97 quirk facility
In-Reply-To: <419CE98B.2090304@pobox.com>
Message-ID: <Pine.LNX.4.53.0411181936050.8260@yvahk01.tjqt.qr>
References: <20041117163016.A5351@tuxdriver.com> <20041117145644.005e54ff.akpm@osdl.org>
 <419CE98B.2090304@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Dumb question: why not just use the ALSA driver?
>
>Until we actually remove the OSS drivers, it's sorta silly to leave them
>broken.

It's just as silly to fix something we're removing anyway.



Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
