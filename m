Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261490AbULNMZp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261490AbULNMZp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 07:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261491AbULNMZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 07:25:45 -0500
Received: from [203.152.41.3] ([203.152.41.3]:5830 "EHLO picard.ine.co.th")
	by vger.kernel.org with ESMTP id S261490AbULNMZj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 07:25:39 -0500
Subject: Re: kernel (64bit) 4GB memory support
From: Rudolf Usselmann <rudi@asics.ws>
Reply-To: rudi@asics.ws
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0412120934160.14734@montezuma.fsmlabs.com>
References: <1102752990.17081.160.camel@cpu0>  <41BAC68D.6050303@pobox.com>
	 <1102760002.10824.170.camel@cpu0>  <41BB32A4.2090301@pobox.com>
	 <1102824735.17081.187.camel@cpu0>
	 <Pine.LNX.4.61.0412112141180.7847@montezuma.fsmlabs.com>
	 <1102828235.17081.189.camel@cpu0>
	 <Pine.LNX.4.61.0412120131570.7847@montezuma.fsmlabs.com>
	 <1102842902.10322.200.camel@cpu0>
	 <Pine.LNX.4.61.0412120934160.14734@montezuma.fsmlabs.com>
Content-Type: text/plain
Organization: ASICS.ws - Solutions for your ASICS & FPGA needs -
Message-Id: <1103027130.3650.73.camel@cpu0>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 14 Dec 2004 19:25:31 +0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-12-12 at 23:35, Zwane Mwaikambo wrote:
> On Sun, 12 Dec 2004, Rudolf Usselmann wrote:
> 
> > ok, un-installed nvidia drivers ...
> > 
> > boot3.log shows a kernel panic as it is starting to run fsck
> > without me involving any user commands.
> > 
> > b004.log - I tried again (after doing a fsck with only 2gb)
> > and again it did not make it to a login prompt.
> 
> Thanks for reproducing that, is there any possible chance you could try 
> 2.6.10-rc2-mm4?

Actually I tried "2.6.10-rc3" a few days ago, and had the same
results. Do you still want me to try "2.6.10-rc2-mm4" ?

Thanks !
rudi

