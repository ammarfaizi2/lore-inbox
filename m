Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262229AbUJZLVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262229AbUJZLVT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 07:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262236AbUJZLTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 07:19:12 -0400
Received: from [195.23.16.24] ([195.23.16.24]:45733 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S262239AbUJZLRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 07:17:24 -0400
Message-ID: <417E3235.9060604@grupopie.com>
Date: Tue, 26 Oct 2004 12:17:09 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
Cc: "Nico Augustijn." <kernel@janestarz.com>, hvr@gnu.org,
       clemens@endorphin.org, linux-kernel@vger.kernel.org
Subject: Re: Cryptoloop patch for builtin default passphrase
References: <200410251354.31226.kernel@janestarz.com> <200410251719.i9PHJmOi009687@turing-police.cc.vt.edu> <417D38F7.1040204@grupopie.com> <200410251754.i9PHsVrI018284@turing-police.cc.vt.edu>            <417D44A7.2030904@grupopie.com> <200410251905.i9PJ5Rrj013717@turing-police.cc.vt.edu>
In-Reply-To: <200410251905.i9PJ5Rrj013717@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.28.0.3; VDF: 6.28.0.38; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> On Mon, 25 Oct 2004 19:23:35 BST, Paulo Marques said:
> 
> 
>>(why would you need confidential information to boot in the first place?)
> 
> 
> The problem is not that the info in the NVRAM is "confidential",
> but that most of it is "configuration".

I can why we were disagreeing, then.

I was assuming that these bytes were otherwise unused, because this 
didn't make any sense to me otherwise.

If they are used for BIOS configuration, then I completely agree with 
you. Sorry for the noise.

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)
