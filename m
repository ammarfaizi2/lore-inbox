Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbTHZSc2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 14:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262246AbTHZSc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 14:32:28 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:11457 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261851AbTHZScM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 14:32:12 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Guillaume Morin <guillaume@morinfr.org>
Subject: Re: [PATCH resend #1] fix cu3088 group write
Date: Mon, 25 Aug 2003 13:17:04 +0200
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <mi9I.54n.13@gated-at.bofh.it> <200308261804.h7QI4OxB057826@d12relay02.megacenter.de.ibm.com> <20030826182101.GF1111@siri.morinfr.org>
In-Reply-To: <20030826182101.GF1111@siri.morinfr.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200308251313.18458.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 26 August 2003 20:21, Guillaume Morin wrote:

> I don't know what you call "not right". My fix was the safest bet. It is
> right but yours is cleaner.

Yes, I only meant that your version wasn't the way I wanted it, not
that it was buggy like my original code.

	Arnd <><


