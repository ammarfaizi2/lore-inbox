Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262660AbRFBTGT>; Sat, 2 Jun 2001 15:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262665AbRFBTGJ>; Sat, 2 Jun 2001 15:06:09 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:3856 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262660AbRFBTFv>; Sat, 2 Jun 2001 15:05:51 -0400
Subject: Re: missing sysrq
To: hpa@zytor.com (H. Peter Anvin)
Date: Sat, 2 Jun 2001 20:03:49 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9f97hu$83v$1@cesium.transmeta.com> from "H. Peter Anvin" at Jun 01, 2001 04:13:02 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E156Ggf-00021X-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Let me guess... you're using a RedHat system?  RedHat, for some
> idiotic reason, defaults to actively turning this off for you (and
> they turn Stop-A off on SPARC, too.)
> 

We turn it off by default because its a rather large dangerous security
hole to leave around when a naiive user makes a basic installation. It is much
better that it is enabled by someone who knows what they are doing and makes
the decision to do so. Thats why we contributed the patch to make syrq runtime
configurable

Tools like powertweak even give you a nice gui interface for managing it.

