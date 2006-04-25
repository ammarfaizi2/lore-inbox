Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932289AbWDYTBf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbWDYTBf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 15:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751527AbWDYTBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 15:01:34 -0400
Received: from baldrick.bootc.net ([83.142.228.48]:65256 "EHLO
	baldrick.bootc.net") by vger.kernel.org with ESMTP id S1751514AbWDYTBd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 15:01:33 -0400
In-Reply-To: <20060425161139.87285.qmail@web26109.mail.ukl.yahoo.com>
References: <20060425161139.87285.qmail@web26109.mail.ukl.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <9C02B13C-8615-440B-A08C-AC463CC2E0AE@bootc.net>
Cc: Nix <nix@esperi.org.uk>, Arjan van de Ven <arjan@infradead.org>,
       drepper@gmail.com, linux-kernel@vger.kernel.org,
       linux-security-module@vger.kernel.org,
       disec-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
From: Chris Boot <bootc@bootc.net>
Subject: Re: [ANNOUNCE] Release Digsig 1.5: kernel module for run-timeauthentication of binaries
Date: Tue, 25 Apr 2006 20:01:24 +0100
To: Axelle Apvrille <axelle_apvrille@yahoo.fr>
X-Mailer: Apple Mail (2.749.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 Apr 2006, at 17:11, Axelle Apvrille wrote:

> - finally, note you also have choice not to sign this
> elf loader of yours. If it isn't signed, it won't ever
> run ;-)

Wouldn't you need to sign, say, /lib/ld-linux.so? In that case, you  
can simply get it to load an execute almost anything that's ELF, even  
on filesystems marked noexec, if I'm not mistaken...

Chris

-- 
Chris Boot
bootc@bootc.net
http://www.bootc.net/


