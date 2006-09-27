Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031198AbWI0W6r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031198AbWI0W6r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 18:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031199AbWI0W6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 18:58:47 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:35757 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1031198AbWI0W6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 18:58:46 -0400
Subject: Re: [PATCH] Chipset addition for the VIA Southbridge workaround /
	quirk
From: Lee Revell <rlrevell@joe-job.com>
To: Michiel de Boer <x@rebelhomicide.demon.nl>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <451AFCA1.4060407@rebelhomicide.demon.nl>
References: <451AE795.6030804@rebelhomicide.demon.nl>
	 <1159393487.1275.52.camel@mindpipe>
	 <451AFCA1.4060407@rebelhomicide.demon.nl>
Content-Type: text/plain
Date: Wed, 27 Sep 2006 18:59:20 -0400
Message-Id: <1159397960.1275.63.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-28 at 00:35 +0200, Michiel de Boer wrote:
> I might have led you to think i meant an onboard card because of my 
> wording, sorry.
> It's a PCI extension card, here's some output from lspci:
> 
> 00:09.0 Multimedia audio controller [0401]: Creative Labs SB Live! 
> EMU10k1 [1102:0002] (rev 08) 

Ah, OK.  Then this is going to be the old SBLive!/686B bug.  Talk about
a blast from the past... :-P

Lee

