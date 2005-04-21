Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261876AbVDUUze@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261876AbVDUUze (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 16:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261878AbVDUUze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 16:55:34 -0400
Received: from hermes.domdv.de ([193.102.202.1]:50961 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S261876AbVDUUz3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 16:55:29 -0400
Message-ID: <42681340.1080104@domdv.de>
Date: Thu, 21 Apr 2005 22:55:28 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: rjw@sisk.pl, Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.12-rc3: various swsusp problems
References: <Pine.LNX.4.58.0504201728110.2344@ppc970.osdl.org> <4267DC2E.9030102@domdv.de> <20050421185717.GB475@openzaurus.ucw.cz>
In-Reply-To: <20050421185717.GB475@openzaurus.ucw.cz>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> Are they new or were they in -rc2, too?

Some further backtracking:

The nic problem is already present in 2.6.12-rc1.
The pcmcia hang problem is not present in 2.6.12-rc1.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
