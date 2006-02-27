Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964805AbWB0Uqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964805AbWB0Uqq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 15:46:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbWB0Uqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 15:46:46 -0500
Received: from main.gmane.org ([80.91.229.2]:17856 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964805AbWB0Uqp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 15:46:45 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Matthieu CASTET <castet.matthieu@free.fr>
Subject: Re: libata PATA patch for 2.6.16-rc5
Date: Mon, 27 Feb 2006 21:46:14 +0100
Message-ID: <pan.2006.02.27.20.46.14.26813@free.fr>
References: <1141054370.3089.0.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cac94-1-81-57-151-96.fbx.proxad.net
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le Mon, 27 Feb 2006 15:32:50 +0000, Alan Cox a écrit :

> This is at
> 	http://zeniv.linux.org.uk/~alan/IDE
> 
> Some more fixes, and the ALi driver should now work although I've yet to
> finish the MWDMA work or finish chasing down the slow performance.

Is there some hardware that need more testing than others ?

I have machines with 
 VIA + SIL680
 PIIX + CMD648
 PIXX
 CMD640 + ISAPnp

But I am quite busy and can't test on all of them.

Matthieu

