Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262637AbTJAWqK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 18:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262651AbTJAWqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 18:46:10 -0400
Received: from [62.67.222.139] ([62.67.222.139]:9122 "EHLO mail.ku-gbr.de")
	by vger.kernel.org with ESMTP id S262637AbTJAWqH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 18:46:07 -0400
Date: Thu, 2 Oct 2003 00:44:58 +0200
From: Konstantin Kletschke <konsti@ludenkalle.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Date/UnixTime of SysRq state dump
Message-ID: <20031001224458.GA16165%konsti@ludenkalle.de>
Reply-To: Konstantin Kletschke <konsti@ludenkalle.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20031001182859.GA4081%konsti@ludenkalle.de> <20031001214846.GB13051@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031001214846.GB13051@matchmail.com>
Organization: Kletschke & Uhlig GbR
User-Agent: Mutt/1.5.4i-ja.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Mike Fedyk <mfedyk@matchmail.com> [Wed, Oct 01, 2003 at 02:48:46PM -0700]:
> 
> Reproduce without tainting please...
> 
> Really that should have been the first thing to try...

Ya, OK. I understand. It is really acquired to reproduce this, when
possible, with an untainted kernel... Otherwise it is not possible to
work, you really do not know what this _huge_ module does...

I updated to 2.6.0-test6-mm1 yesterday, which lifes still after day
change :) and when this freezes I will get rid of the nvidia module to
reproduce that with the nv driver (problem is, only one monitor then!)
and only then I will report.

Really, I only wanted to know if a day change can trigger a kernel
freeze, but, I realize now, one does not know what goes on with that:

nvidia               1709612  10

o_O

Regards, Konsti

-- 
2.6.0-test6-mm1
Konstantin Kletschke <konsti@ludenkalle.de>, <konsti@ku-gbr.de>
GPG KeyID EF62FCEF
Fingerprint: 13C9 B16B 9844 EC15 CC2E  A080 1E69 3FDA EF62 FCEF
keulator.homelinux.org up 5:35, 29 users
