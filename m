Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261816AbVCOTvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261816AbVCOTvI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 14:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261803AbVCOTsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 14:48:05 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:23498 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261793AbVCOToI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 14:44:08 -0500
Subject: Re: x86: spin_unlock(), spin_unlock_irq() & others are out of line
	?
From: Lee Revell <rlrevell@joe-job.com>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: linux-kernel@vger.kernel.org, vda@port.imtp.ilyichevsk.odessa.ua
In-Reply-To: <4236BD87.6000408@cosmosbay.com>
References: <42348474.7040808@aknet.ru>	<20050313201020.GB8231@elf.ucw.cz>
	 <4234A8DD.9080305@aknet.ru>
	 <Pine.LNX.4.58.0503131306450.2822@ppc970.osdl.org>
	 <4234B96C.9080901@aknet.ru>
	 <20050314192943.GG18826@devserv.devel.redhat.com>
	 <4235ED35.1000405@aknet.ru> <20050314193447.47ca6754.akpm@osdl.org>
	 <4236BD87.6000408@cosmosbay.com>
Content-Type: text/plain
Date: Tue, 15 Mar 2005 14:44:02 -0500
Message-Id: <1110915842.17931.15.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-15 at 11:48 +0100, Eric Dumazet wrote:
> Is it a regression, or is it needed ?
> 

Please see the "Completely out of line spinlocks" thread from about a
month ago.

Lee

