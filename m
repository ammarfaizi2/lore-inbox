Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266882AbUFYWK5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266882AbUFYWK5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 18:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266337AbUFYWK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 18:10:56 -0400
Received: from pop.gmx.net ([213.165.64.20]:8165 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266882AbUFYWKW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 18:10:22 -0400
X-Authenticated: #4512188
Message-ID: <40DCA2CA.6060102@gmx.de>
Date: Sat, 26 Jun 2004 00:10:18 +0200
From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040618)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.7-ck2 (was Re: 2.6.7-ck1)
References: <40DC2D28.5020605@kolivas.org> <40DC2DAF.2090204@kolivas.org>
In-Reply-To: <40DC2DAF.2090204@kolivas.org>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

like in the other thread, I also think there is something fishy about 
staircase 7.4.

Now when I compile something int the backgorund (eg. xine-lib, without 
setting higher nice value) and work in kdevelop at the same time, here 
compiling takes "endless" (it finishes, but takes minutes for what 
should be done in seconds) time.

Revertung to staircase 7.3 (on ck1) it seems to be ok.

Hth

Prakash
