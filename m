Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261248AbVDNBPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbVDNBPM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 21:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbVDNBPL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 21:15:11 -0400
Received: from quechua.inka.de ([193.197.184.2]:41405 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261248AbVDNBNp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 21:13:45 -0400
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH encrypted swsusp 1/3] core functionality
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <20050413233904.GA31174@gondor.apana.org.au>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1DLsvN-0008VO-00@calista.eckenfels.6bone.ka-ip.net>
Date: Thu, 14 Apr 2005 03:13:41 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20050413233904.GA31174@gondor.apana.org.au> you wrote:
> The dmcrypt swap can only be unlocked by the user with a passphrase,
> which is analogous to how you unlock your ssh private key stored
> on the disk using a passphrase.

We talk about the unlocked system getting hacked. However I am not why the
hacker would head for the swap if he can as well read the ram.

Gruss
Bernd
