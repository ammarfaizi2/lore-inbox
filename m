Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265701AbSJXXrM>; Thu, 24 Oct 2002 19:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265710AbSJXXrM>; Thu, 24 Oct 2002 19:47:12 -0400
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:18827 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S265701AbSJXXrK>; Thu, 24 Oct 2002 19:47:10 -0400
From: SL Baur <steve@kbuxd.necst.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15800.34980.899069.115419@sofia.bsd2.kbnes.nec.co.jp>
Date: Fri, 25 Oct 2002 08:56:20 +0900
To: Philippe Troin <phil@fifi.org>
Cc: Hanna Linder <hannal@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, tmolina@cox.net, haveblue@us.ibm.com
Subject: Re: more aic7xxx boot failure
In-Reply-To: <87hefbxw3d.fsf@ceramic.fifi.org>
References: <8800000.1035498319@w-hlinder>
	<87lm4nxxnj.fsf@ceramic.fifi.org>
	<16660000.1035501142@w-hlinder>
	<87hefbxw3d.fsf@ceramic.fifi.org>
X-Mailer: VM 7.03 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philippe Troin writes:

> Now, if the driver could be fixed, that would be nicer...

I've forward ported the aic7xxx driver in 2.4.20-pre11 (which works
excellently for me) to 2.5.44.  I'll post the patches later this morning.

