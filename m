Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965239AbWHOGxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965239AbWHOGxE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 02:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965251AbWHOGxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 02:53:04 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:1206 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S965239AbWHOGxB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 02:53:01 -0400
Date: Tue, 15 Aug 2006 08:52:11 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Antonino A. Daplas" <adaplas@gmail.com>
cc: James C Georgas <jgeorgas@rogers.com>, linux-kernel@vger.kernel.org
Subject: Re: vga text console
In-Reply-To: <1155622311.3854.1.camel@daplas.org>
Message-ID: <Pine.LNX.4.61.0608150851220.3819@yvahk01.tjqt.qr>
References: <1155604313.8131.4.camel@Rainsong>  <1155604928.3948.8.camel@daplas.org>
  <1155605197.3948.10.camel@daplas.org>  <1155606109.8131.13.camel@Rainsong>
  <1155606849.3948.17.camel@daplas.org>  <1155607768.8131.22.camel@Rainsong>
 <1155622311.3854.1.camel@daplas.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I'm kind of surprised that the VGA console can't be built as a module,
>> like the other console drivers in the kernel can be. Is this on purpose,
>> or is it just that nobody has gotten around to it?
>
>It's possible to make vgacon modular, the changes required will be
>minimal. It would seem that nobody ever had a need for it, so that was
>never done.

Maybe someday this will happen automagically when VGA/FB switching 
is finished.


Jan Engelhardt
-- 
