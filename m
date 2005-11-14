Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932124AbVKNVDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbVKNVDw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 16:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932126AbVKNVDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 16:03:52 -0500
Received: from gate.crashing.org ([63.228.1.57]:41709 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932124AbVKNVDv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 16:03:51 -0500
Subject: Re: 2.6.15-rc1 fails to boot on eMac
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mikael Pettersson <mikpe@user.it.uu.se>
Cc: paulus@samba.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <17272.46529.847423.310952@alkaid.it.uu.se>
References: <17272.46529.847423.310952@alkaid.it.uu.se>
Content-Type: text/plain
Date: Tue, 15 Nov 2005 08:03:00 +1100
Message-Id: <1132002180.5504.206.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-14 at 17:05 +0100, Mikael Pettersson wrote:
> Linux kernel 2.6.15-rc1 (vanilla, not patched, compiled with
> gcc-3.4.4) refuses to boot on my Apple eMac (1.25GHz G4). After
> yaboot has loaded the kernel the output on the console is:

Yup, there is something wrong, I'm still investigating.

Ben.


