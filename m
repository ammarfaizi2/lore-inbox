Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964869AbVKGQh4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964869AbVKGQh4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 11:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964867AbVKGQh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 11:37:56 -0500
Received: from [81.2.110.250] ([81.2.110.250]:22946 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S964869AbVKGQhz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 11:37:55 -0500
Subject: Re: [ANNOUNCE] Ubuntu kernel tree
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Daniel Drake <dsd@gentoo.org>
Cc: Ben Collins <bcollins@ubuntu.com>, linux-kernel@vger.kernel.org
In-Reply-To: <436F81D1.7000100@gentoo.org>
References: <20051106013752.GA13368@swissdisk.com>
	 <436E17CA.3060803@gentoo.org>
	 <1131316729.1212.58.camel@localhost.localdomain>
	 <436F81D1.7000100@gentoo.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 07 Nov 2005 17:08:31 +0000
Message-Id: <1131383311.11265.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-11-07 at 16:33 +0000, Daniel Drake wrote:
> Source RPM's will just contain a Linux kernel tree with your patches already 
> applied, right?

Of course not. Its an rpm file. RPM files contain a set of broken out
patches and base tar ball plus controlling rules for application. It's
rather more advanced than .deb sources.

Alan

