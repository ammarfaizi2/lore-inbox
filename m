Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932528AbWBPOfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932528AbWBPOfY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 09:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932529AbWBPOfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 09:35:24 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:1257 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932528AbWBPOfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 09:35:23 -0500
Subject: Re: Re[2]: 2.6.16 serious consequences / GPL_EXPORT_SYMBOL / USB
	drivers of major vendor excluded
From: Arjan van de Ven <arjan@infradead.org>
To: s.schmidt@avm.de
Cc: Greg KH <greg@kroah.com>, torvalds@osdl.org, kkeil@suse.de,
       linux-kernel@vger.kernel.org, opensuse-factory@opensuse.org,
       libusb-devel@lists.sourceforge.net
In-Reply-To: <OFED05BE20.31E2BACE-ONC1257115.005DE6CA-C1257117.004F2C48@avm.de>
References: <OFED05BE20.31E2BACE-ONC1257115.005DE6CA-C1257117.004F2C48@avm.de>
Content-Type: text/plain
Date: Thu, 16 Feb 2006 15:35:06 +0100
Message-Id: <1140100506.4117.79.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-16 at 15:24 +0100, s.schmidt@avm.de wrote:
> To anticipate any "open vs. closed source" discussion:Only a
> handful of companies worldwide have such know-how. With regard to our
> competitive situation, we have to protect our hard-won intellectual
> property and therefore cannot open the closed source part of the
> driver.


where in the license of the kernel does it say that this is a valid
exception to the license ?

You're writing drivers with linux in mind. You're writing them
explicitly for linux, using Linux code. And you distribute the result.

If your company really wants to be a good linux player, be a good linux
player rather than contributing to the biggest threat to linux right
now...

