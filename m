Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285484AbRLSUsn>; Wed, 19 Dec 2001 15:48:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285483AbRLSUsc>; Wed, 19 Dec 2001 15:48:32 -0500
Received: from mta23-acc.tin.it ([212.216.176.76]:53703 "EHLO fep23-svc.tin.it")
	by vger.kernel.org with ESMTP id <S285469AbRLSUs2>;
	Wed, 19 Dec 2001 15:48:28 -0500
Content-Type: text/plain; charset=US-ASCII
From: Flavio Stanchina <flavio.stanchina@tin.it>
Organization: not at all
To: Dave Jones <davej@suse.de>
Subject: Re: 2.4.17-rc2 oopses when unloading hid.o
Date: Wed, 19 Dec 2001 21:48:21 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0112192118230.26043-100000@Appserv.suse.de>
In-Reply-To: <Pine.LNX.4.33.0112192118230.26043-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011219204822.IXDQ15319.fep23-svc.tin.it@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 19 December 2001 21:19, Dave Jones wrote:

> And what proprietory modules were loaded ?
> Can you repeat the problem without them?

They were the VMware Workstation 3.0.0 modules. Sorry, I forgot to mention 
because I had already unloaded them for unrelated reasons.

The second oops I reported is from a clean kernel IIRC, however I can 
reproduce the same oopses even without tainting modules.

-- 
Ciao,
    Flavio Stanchina
    Trento - Italy

"The best defense against logic is ignorance."
http://spazioweb.inwind.it/fstanchina/
