Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263317AbTJBJQO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 05:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263315AbTJBJQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 05:16:14 -0400
Received: from [62.67.222.139] ([62.67.222.139]:8617 "EHLO mail.ku-gbr.de")
	by vger.kernel.org with ESMTP id S263317AbTJBJQL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 05:16:11 -0400
Date: Thu, 2 Oct 2003 11:16:38 +0200
From: Konstantin Kletschke <konsti@ludenkalle.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Date/UnixTime of SysRq state dump
Message-ID: <20031002091638.GA15471@synertronixx3>
Reply-To: konsti@ludenkalle.de
References: <20031001182859.GA4081%konsti@ludenkalle.de> <20031001162141.278442d7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031001162141.278442d7.akpm@osdl.org>
X-PGP-Key: http://www.ludenkalle.de/konsti/pubkey.asc
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 01, 2003 at 04:21:41PM -0700, Andrew Morton wrote:

> > http://ludenkalle.de/capture-2003-09-30-linux-2.6.0-test5-mm4.log
> 
> mpd           R current  17897  17786 17898               (NOTLB)
> 
> it might be coincidence, it might not be.  Please gather another sysrq
> trace next time it happens, just like that one.

OK, I will keep an eye on it. Poorly I upgraded Kernel and mpd after
that. But if it happens again I will get another sysrq and after that
try that with same versions but untainted, lets see :)

Regards, Konsti

-- 
2.6.0-test1-mm2
Konstantin Kletschke <konsti@ludenkalle.de>, <konsti@ku-gbr.de>
GPG KeyID EF62FCEF
Fingerprint: 13C9 B16B 9844 EC15 CC2E  A080 1E69 3FDA EF62 FCEF
keulator.homelinux.org up 3 days, 2
