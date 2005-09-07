Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751179AbVIGBAn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbVIGBAn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 21:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbVIGBAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 21:00:43 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:48836 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751179AbVIGBAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 21:00:42 -0400
Subject: Re: [PATCH 01/24] V4L: Common part Updates and tuner additions
From: hermann pitton <hermann.pitton@onlinehome.de>
To: Linux and Kernel Video <video4linux-list@redhat.com>
Cc: mchehab@brturbo.com.br, linux-kernel@vger.kernel.org
In-Reply-To: <20050906170128.243a3a39.akpm@osdl.org>
References: <431cb7f6.3a1Y2AL2UcB0Asbo%mchehab@brturbo.com.br>
	 <20050906170128.243a3a39.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 07 Sep 2005 03:15:42 +0200
Message-Id: <1126055743.4191.7.camel@pc08.localdom.local>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:17498165d1d898a28ef793368f1053bc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, den 06.09.2005, 17:01 -0700 schrieb Andrew Morton:
> Two of these patches:
> 
> v4l-adds-the-adapter-number-and-i2c-address-to.patch
> v4l-allows-clearer-message-prefixes-containing-the-i2c-for-tveeprom_hauppauge_analog.patch
> 
> throw great reject storms, due to changes in Linus's current tree.  Greg's
> i2c stuff.
> 
> I'm not confident that the v4l changes will work without those two patches
> and I'm not confident that they'll work against all the i2c changes, so
> could you please redo all these patches against current -linus or most
> recent -mm, retest and resend?
> 
> Thanks.

Hi,

I'm very confident that all other patches should work without these two,
if not, it is not related to this two patches, but right, let's check
more carefully and if necessary resend.

Greetings,
Hermann

