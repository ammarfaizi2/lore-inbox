Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262515AbVAJUcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262515AbVAJUcS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 15:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262508AbVAJUcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 15:32:15 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:26317 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262520AbVAJUaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 15:30:20 -0500
Subject: Re: Reviving the concept of a stable series
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adam Sampson <azz@us-lot.org>
Cc: L A Walsh <lkml@tlinx.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <y2ais65z9ef.fsf@cartman.at.fivegeeks.net>
References: <200501031424.j03EOV2t029019@laptop11.inf.utfsm.cl>
	 <41E07711.3040008@tlinx.org>  <y2ais65z9ef.fsf@cartman.at.fivegeeks.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105383229.12028.104.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 10 Jan 2005 19:24:02 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-01-10 at 13:44, Adam Sampson wrote:
> L A Walsh <lkml@tlinx.org> writes:
> One option would be a "Linux Legacy" project, similar to the Fedora
> Legacy project that backports updates to old Red Hat/Fedora Core
> releases: a central service that'd collect bug fixes for released
> kernels that distributors could then base their kernels on. That way,
> we'd get the stability advantages of vendor kernels without needing to
> repeat the effort for each distribution.
> 
> Maybe some of the distribution vendors might be interested in setting
> up something like this?

It would be essentially unmanageable unless you picked only one specific
kernel and configuration set to support. Needless to say you won't find
vendors even ship the same kernel. Nor for that matter would a few
backports magically give you stability.

