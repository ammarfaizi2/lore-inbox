Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751165AbWC1RNY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbWC1RNY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 12:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbWC1RNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 12:13:24 -0500
Received: from smtpout.mac.com ([17.250.248.84]:12765 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751165AbWC1RNX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 12:13:23 -0500
In-Reply-To: <ufazmjaec9q.fsf@epithumia.math.uh.edu>
References: <200603141619.36609.mmazur@kernel.pl> <20060326065205.d691539c.mrmacman_g4@mac.com> <4426A5BF.2080804@tremplin-utc.net> <200603261609.10992.rob@landley.net> <44271E88.6040101@tremplin-utc.net> <5DC72207-3C0B-44C2-A9E5-319C0A965E9D@mac.com> <Pine.LNX.4.61.0603281619300.27529@yvahk01.tjqt.qr> <36A8C3CC-3E4D-4158-AABB-F4D2C66AA8CD@mac.com> <442960B6.2040502@tremplin-utc.net> <7E2F0C3C-4091-4EEB-8E10-C1F58F94BD59@mac.com> <ufazmjaec9q.fsf@epithumia.math.uh.edu>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <54199D84-7DB7-434E-BA83-9B2658182124@mac.com>
Cc: Eric Piel <Eric.Piel@tremplin-utc.net>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, Rob Landley <rob@landley.net>,
       nix@esperi.org.uk, mmazur@kernel.pl, linux-kernel@vger.kernel.org,
       llh-discuss@lists.pld-linux.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [OT] Non-GCC compilers used for linux userspace
Date: Tue, 28 Mar 2006 12:13:15 -0500
To: Jason L Tibbitts III <tibbs@math.uh.edu>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 28, 2006, at 11:59:13, Jason L Tibbitts III wrote:
>>>>>> "KM" == Kyle Moffett <mrmacman_g4@mac.com> writes:
>> So does anybody compile userspace under anything other than GCC or  
>> Intel compilers?  Do any such compilers even exist?
>
> PGI and PathScale are around.  Lahey, too, although they seem to  
> just do Fortran now.
>
> I doubt you'd want to worry about compiling the entire userland  
> with these compilers, however.

Mainly I want to know if I should even bother making the kabi headers  
compile with anything other than GCC.  Judging from the apparently  
negligible number of users, it doesn't sound like something I should  
spend much or any time on, at least for now.

Cheers,
Kyle Moffett

