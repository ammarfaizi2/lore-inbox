Return-Path: <linux-kernel-owner+w=401wt.eu-S1762501AbWLJVAd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762501AbWLJVAd (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 16:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762589AbWLJVAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 16:00:33 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:55175 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762501AbWLJVAc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 16:00:32 -0500
Subject: Re: PAE/NX without performance drain?
From: Arjan van de Ven <arjan@infradead.org>
To: John Richard Moser <nigelenki@comcast.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <457C747A.6010702@comcast.net>
References: <457B1F02.7030409@comcast.net>
	 <1165743478.27217.187.camel@laptopd505.fenrus.org>
	 <457C28F8.4050409@comcast.net>
	 <1165779603.27217.231.camel@laptopd505.fenrus.org>
	 <457C747A.6010702@comcast.net>
Content-Type: text/plain
Organization: Intel International BV
Date: Sun, 10 Dec 2006 22:00:31 +0100
Message-Id: <1165784431.27217.237.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 
> 
> OpenSuSE and Fedora Core 6 both fail this; I checked the .config for the
> default kernels (by proxy on OpenSuSE 10.2; I asked someone) and ran my
> test case on FC6 (LiveCD from
> http://www.fedoraunity.org/news-archives/fedora-core-6-zod-live-spins-released).

liveCD's don't count since they pick the most common kernel; afaik
fedora has a kernel-PAE and installs this on the NX capable machines...

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

