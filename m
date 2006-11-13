Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755141AbWKMPiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755141AbWKMPiF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 10:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755145AbWKMPiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 10:38:05 -0500
Received: from mx1.suse.de ([195.135.220.2]:644 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1755141AbWKMPiC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 10:38:02 -0500
From: Andi Kleen <ak@suse.de>
To: Jeff Garzik <jeff@garzik.org>
Subject: Re: AHCI power saving (was Re: Ten hours on X60s)
Date: Mon, 13 Nov 2006 16:37:56 +0100
User-Agent: KMail/1.9.5
Cc: Pavel Machek <pavel@ucw.cz>, John Fremlin <not@just.any.name>,
       kernel list <linux-kernel@vger.kernel.org>, htejun@gmail.com,
       jim.kardach@intel.com
References: <87k639u55l.fsf-genuine-vii@john.fremlin.org> <20061113142219.GA2703@elf.ucw.cz> <45589008.1080001@garzik.org>
In-Reply-To: <45589008.1080001@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611131637.56737.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Therein lies a key problem.  Turning on all of AHCI's aggressive power 
> management features DOES save a lot of power.  But at the same time, it 
> shortens the life of your hard drive, particularly hard drives that are 
> really PATA, but have a PATA<->SATA bridge glued on the drive to enable 
> connection to SATA controllers.

How does it shorten its life?

-Andi
