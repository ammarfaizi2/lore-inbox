Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271346AbTHDA4e (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 20:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271352AbTHDA4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 20:56:34 -0400
Received: from ns2.eclipse.net.uk ([212.104.129.133]:30482 "EHLO
	smtp2.ex.eclipse.net.uk") by vger.kernel.org with ESMTP
	id S271346AbTHDA4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 20:56:32 -0400
From: Ian Hastie <ianh@iahastie.clara.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Turning off automatic screen clanking
Date: Mon, 4 Aug 2003 01:56:28 +0100
User-Agent: KMail/1.5.3
References: <eFZJ.6X7.29@gated-at.bofh.it> <frB6.8gE.7@gated-at.bofh.it> <frodoid.frodo.87brv7t46v.fsf@usenet.frodoid.org>
In-Reply-To: <frodoid.frodo.87brv7t46v.fsf@usenet.frodoid.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308040156.30289.ianh@iahastie.local.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 03 Aug 2003 11:40, Julien Oster wrote:
> My monitor (Iiyama Vision Master Pro 21) turns its power off as soon
> as it realizes that the screen was staying black for a certain amount
> of time (configurable). It hasn't anything to do with power management
> stuff, since I can also reproduce it by turning the cursor off and
> then typing "clear; sleep 10000000" in my shell.

My old monitor, Iiyama VisionMaster Pro 400, was meant to do this too, but it 
never worked.  It only ever went into power saving when the distro I had 
installed set this option during boot.  Up till then I'd simply believed the 
kernel config help where it mentioned not doing power saving and so never 
looked for the option!  Up to then I'd only had DPMS available through X.  

BTW, I assume you have screen blanking and power saving disabled by setterm 
when the monitor goes into power saving mode?

-- 
Ian.

