Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263390AbVFYKgm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263390AbVFYKgm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 06:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263391AbVFYKgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 06:36:42 -0400
Received: from [85.8.12.41] ([85.8.12.41]:55224 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S263390AbVFYKew (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 06:34:52 -0400
Message-ID: <42BD334A.9090900@drzeus.cx>
Date: Sat, 25 Jun 2005 12:34:50 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ed Sweetman <safemode@comcast.net>
CC: Bjorn Helgaas <bjorn.helgaas@hp.com>, LKML <linux-kernel@vger.kernel.org>,
       jgarzik@pobox.com
Subject: Re: 2.6.12 breaks 8139cp
References: <42B9D21F.7040908@drzeus.cx> <200506221534.03716.bjorn.helgaas@hp.com> <42BA69AC.5090202@drzeus.cx> <200506231143.34769.bjorn.helgaas@hp.com> <42BB3428.6030708@drzeus.cx> <42BCBB60.7000508@comcast.net>
In-Reply-To: <42BCBB60.7000508@comcast.net>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Sweetman wrote:

> 2.6.11-mm4 doesn't work. So i'm guessing 2.6.11 wont work either which
> may be why backporting it's via fixes didn't do anything.  I'm gonna
> try vanilla and if that by some crazy chance works, then it'll be
> fairly easy to see what change did it since mm has a nice Changelog.


2.6.11 works fine here so if you're having problems with it I'd say
we're experiencing two different bugs.

Rgds
Pierre

