Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262494AbVGKTpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262494AbVGKTpj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 15:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbVGKTpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 15:45:23 -0400
Received: from spc2-brig1-3-0-cust232.asfd.broadband.ntl.com ([82.1.142.232]:22464
	"EHLO ppgpenguin.kenmoffat.uklinux.net") by vger.kernel.org with ESMTP
	id S262494AbVGKTpL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 15:45:11 -0400
Date: Mon, 11 Jul 2005 20:45:08 +0100 (BST)
From: Ken Moffat <ken@kenmoffat.uklinux.net>
To: linux-kernel@vger.kernel.org
Subject: Re: ondemand cpufreq ineffective in 2.6.12 ?
In-Reply-To: <Pine.LNX.4.58.0507111702410.2222@ppg_penguin.kenmoffat.uklinux.net>
Message-ID: <Pine.LNX.4.58.0507112044001.3450@ppg_penguin.kenmoffat.uklinux.net>
References: <Pine.LNX.4.58.0507111702410.2222@ppg_penguin.kenmoffat.uklinux.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jul 2005, Ken Moffat wrote:

> Hi,
>
>  I've been using the ondemand governor on athlon64 winchesters for a few
> weeks.  I've just noticed that in 2.6.12 the frequency is not
> increasing under load, it remains at the lowest frequency.  This seems
> to be down to something in 2.6.12-rc6, but I've seen at least one report
> since then that ondemand works fine.  Anybody else seeing this problem ?
>

 And just for the record, it's still not working in 2.6.13-rc2.  Oh
well, back to 2.6.11 for this box.

-- 
 das eine Mal als Tragödie, das andere Mal als Farce

