Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261651AbUKHO0c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbUKHO0c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 09:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbUKHO0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 09:26:32 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:47080 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261651AbUKHO0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 09:26:30 -0500
Date: Thu, 4 Nov 2004 14:02:28 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Michal Semler <cijoml@volny.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: swsuspend and total loss of all data :(((
Message-ID: <20041104130228.GE996@openzaurus.ucw.cz>
References: <200411040126.27613.cijoml@volny.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411040126.27613.cijoml@volny.cz>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I hibernated without BT donle (CSR based 16.1.1 fw)  plugged into USB port and 
> started with it plugged in and kernel after successfully loaded image from 
> hdd freezes saying USB device plugged in and info about usb port...
> 
> After press reset kernel started recovering ext3 fs, but all my data are 
> lost...
> 
> PLS fix it in future releases

Hmm, which kernel was it? Any patches applied?
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

