Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265757AbSJYAdM>; Thu, 24 Oct 2002 20:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265755AbSJYAdL>; Thu, 24 Oct 2002 20:33:11 -0400
Received: from tantale.fifi.org ([216.27.190.146]:15771 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id <S265753AbSJYAdJ>;
	Thu, 24 Oct 2002 20:33:09 -0400
To: SL Baur <steve@kbuxd.necst.nec.co.jp>
Cc: Hanna Linder <hannal@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, tmolina@cox.net, haveblue@us.ibm.com
Subject: Re: more aic7xxx boot failure
References: <8800000.1035498319@w-hlinder> <87lm4nxxnj.fsf@ceramic.fifi.org>
	<16660000.1035501142@w-hlinder> <87hefbxw3d.fsf@ceramic.fifi.org>
	<15800.34980.899069.115419@sofia.bsd2.kbnes.nec.co.jp>
From: Philippe Troin <phil@fifi.org>
Date: 24 Oct 2002 17:39:13 -0700
In-Reply-To: <15800.34980.899069.115419@sofia.bsd2.kbnes.nec.co.jp>
Message-ID: <87d6pzxsge.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SL Baur <steve@kbuxd.necst.nec.co.jp> writes:

> Philippe Troin writes:
> 
> > Now, if the driver could be fixed, that would be nicer...
> 
> I've forward ported the aic7xxx driver in 2.4.20-pre11 (which works
> excellently for me) to 2.5.44.  I'll post the patches later this morning.

I've seen the problem Hanna was talking about in 2.4.19 and
2.4.20-pre11.

Phil.
