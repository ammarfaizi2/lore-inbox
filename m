Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130105AbQKBHPw>; Thu, 2 Nov 2000 02:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130389AbQKBHPn>; Thu, 2 Nov 2000 02:15:43 -0500
Received: from proxy.povodiodry.cz ([212.47.5.214]:38647 "HELO pc11.op.pod.cz")
	by vger.kernel.org with SMTP id <S130105AbQKBHPc>;
	Thu, 2 Nov 2000 02:15:32 -0500
From: "Vitezslav Samel" <samel@mail.cz>
Date: Thu, 2 Nov 2000 08:15:22 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.0-test10
Message-ID: <20001102081522.A28970@pc11.op.pod.cz>
In-Reply-To: <39FFB221.D6A1B5FF@megsinet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <39FFB221.D6A1B5FF@megsinet.net>; from vanl@megsinet.net on Wed, Nov 01, 2000 at 12:03:13AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi!

> My list of 2.4.0-testX problems
> 
> Problem description:
>  
> 1.  kernel compiled w/o FB support.  When attempting to switch
>     back to X from VC1-6 system locks hard for SMP.  Nada thing
>     fixes this except hard reset... no Alt-SysRq-B, nothing
>     DRI not enabled.  Video card has r128 chipset.


	Me Too (tm). No FB support, no DRI, lock occurs randomly during
	switching back to X from VC. no keyboard, no net, no video (my
	monitor switches off)

	HW:	Asus P2B-D (2xPIII/700)
		ATI Rage Pro r128

	.config or other info available



			Vitezslav Samel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
