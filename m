Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262409AbTFXVud (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 17:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262423AbTFXVud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 17:50:33 -0400
Received: from [62.67.222.139] ([62.67.222.139]:1491 "EHLO kermit")
	by vger.kernel.org with ESMTP id S262409AbTFXVuc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 17:50:32 -0400
Date: Wed, 25 Jun 2003 00:04:36 +0200
From: Konstantin Kletschke <konsti@ludenkalle.de>
To: linux-kernel@vger.kernel.org
Subject: Re: medium Oops on 2.5.73-mm1
Message-ID: <20030624220436.GA1610@sexmachine.doom>
Reply-To: Konstantin Kletschke <konsti@ludenkalle.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030624164026.GA2934@sexmachine.doom> <20030624210414.GA1533@sexmachine.doom> <20030624142214.67e5c5f4.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030624142214.67e5c5f4.akpm@digeo.com>
Organization: Kletschke & Uhlig GbR
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton <akpm@digeo.com> [Tue, Jun 24, 2003 at 02:22:14PM -0700]:
> 
> Please see if it is repeatable without the nVidia driver loaded.

Yes, there is no way around that, actually running X with nv driver, and
its hard to use only one Monitor instead of them both :(

But, lets see what is happening without this nvidia.ko module...

Konsti

PS.: Sorry Andrew, again I typed r instead of L so you got an personal
mail from me, this was not intentional!

-- 
2.5.73-mm1
Konstantin Kletschke <konsti@ludenkalle.de>, <konsti@ku-gbr.de>
GPG KeyID EF62FCEF
Fingerprint: 13C9 B16B 9844 EC15 CC2E  A080 1E69 3FDA EF62 FCEF
keulator.homelinux.org up 6 min, 
