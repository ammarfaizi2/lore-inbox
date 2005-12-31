Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751025AbVLaF34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbVLaF34 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 00:29:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbVLaF34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 00:29:56 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:13010 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751025AbVLaF34 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 00:29:56 -0500
Date: Sat, 31 Dec 2005 06:29:52 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Conio sandiago <coniodiago@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: statistics problem
In-Reply-To: <993d182d0512290006k54638f33h79bc17cb99db31e7@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0512310629340.18451@yvahk01.tjqt.qr>
References: <993d182d0512290006k54638f33h79bc17cb99db31e7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi all
>i have a embedded linux.
>if i execute ifconfig eth0 then
>i am able to see the IP address ,but i am not able to see the other
>statistics like Tx errors Rx errors.
>everything is shows as zeros.
>does anyine has some idea about it

Try mounting /proc, ifconfig sadly depends on it to some degree AFAICS.


Jan Engelhardt
-- 
