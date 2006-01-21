Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751215AbWAUWvq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbWAUWvq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 17:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbWAUWvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 17:51:46 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:13023 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751215AbWAUWvp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 17:51:45 -0500
Date: Sat, 21 Jan 2006 23:51:43 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Andrey Borzenkov <arvidjaar@mail.ru>
cc: linux-kernel@vger.kernel.org, Olaf Hering <olh@suse.de>
Subject: Re: cc-version not available to change EXTRA_CFLAGS
In-Reply-To: <200601212207.49483.arvidjaar@mail.ru>
Message-ID: <Pine.LNX.4.61.0601212351170.12696@yvahk01.tjqt.qr>
References: <200601212207.49483.arvidjaar@mail.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Which raises the question - I believed, we support Intel CC for kernel 
>compilation? Or was just just a dream?

Not really. If ICC works though, then it's because ICC was tuned hard to 
behave like GCC.


Jan Engelhardt
-- 
