Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264432AbTKUULk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 15:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264429AbTKUULk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 15:11:40 -0500
Received: from sow.visionpro.com ([63.91.95.5]:19982 "EHLO sow.visionpro.com")
	by vger.kernel.org with ESMTP id S264432AbTKUUL0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 15:11:26 -0500
Message-ID: <F8E34394F337C74EA249580DEE7C240C111C38@chicken.machinevisionproducts.com>
From: Brian McGrew <brian@visionpro.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Error during install
Date: Fri, 21 Nov 2003 12:09:43 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greets,

I'm getting an error "No module aic7xxx found for kernel 2.6.0-test9".  Now
I know that aic7xxx is an aliased module in /etc/modules.conf.  Of course I
can remove it; but what are the repurcussions of removing it.

Also, in the kernle config, I've got scsi support turned on as well as the
aic7xxx selected as a module.  What am I missing here?

-brian

Brian D. McGrew {brian@visionpro.com || brian@doubledimension.com }
--
> My job is so secret ... I don't know what I do!

