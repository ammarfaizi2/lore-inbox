Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264788AbUFGPSB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264788AbUFGPSB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 11:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264772AbUFGPOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 11:14:10 -0400
Received: from smtp.virgilio.it ([212.216.176.142]:8067 "EHLO vsmtp2.tin.it")
	by vger.kernel.org with ESMTP id S263100AbUFGPNW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 11:13:22 -0400
Message-ID: <40C4860C.3070904@stanchina.net>
Date: Mon, 07 Jun 2004 17:13:16 +0200
From: Flavio Stanchina <flavio@stanchina.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Wichert Akkerman <wichert@wiggy.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: kbuild make deb patch
References: <20040607141353.GK21794@wiggy.net>
In-Reply-To: <20040607141353.GK21794@wiggy.net>
X-Enigmail-Version: 0.83.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wichert Akkerman wrote:
> kbuild has had a rpm make target for some time now. Since the concept of
> kernel packages is quite convenient I added a deb target as well, using
> the patch below.

I like the idea a lot, but your patch to the makefile touches quite a 
few things in the clean target that AFAICT are not related to the deb 
target in any way. Perhaps you are diffing from an older tree?

-- 
Ciao, Flavio

