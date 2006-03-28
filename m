Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751114AbWC1RB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbWC1RB7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 12:01:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbWC1RB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 12:01:58 -0500
Received: from nas01.math.uh.edu ([129.7.128.39]:58315 "EHLO nas01.math.uh.edu")
	by vger.kernel.org with ESMTP id S1751114AbWC1RB5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 12:01:57 -0500
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Eric Piel <Eric.Piel@tremplin-utc.net>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, Rob Landley <rob@landley.net>,
       nix@esperi.org.uk, mmazur@kernel.pl, linux-kernel@vger.kernel.org,
       llh-discuss@lists.pld-linux.org
Subject: Re: [OT] Non-GCC compilers used for linux userspace
References: <200603141619.36609.mmazur@kernel.pl>
	<20060326065205.d691539c.mrmacman_g4@mac.com>
	<4426A5BF.2080804@tremplin-utc.net>
	<200603261609.10992.rob@landley.net>
	<44271E88.6040101@tremplin-utc.net>
	<5DC72207-3C0B-44C2-A9E5-319C0A965E9D@mac.com>
	<Pine.LNX.4.61.0603281619300.27529@yvahk01.tjqt.qr>
	<36A8C3CC-3E4D-4158-AABB-F4D2C66AA8CD@mac.com>
	<442960B6.2040502@tremplin-utc.net>
	<7E2F0C3C-4091-4EEB-8E10-C1F58F94BD59@mac.com>
From: Jason L Tibbitts III <tibbs@math.uh.edu>
Date: Tue, 28 Mar 2006 10:59:13 -0600
In-Reply-To: <7E2F0C3C-4091-4EEB-8E10-C1F58F94BD59@mac.com> (Kyle Moffett's
 message of "Tue, 28 Mar 2006 11:20:50 -0500")
Message-ID: <ufazmjaec9q.fsf@epithumia.math.uh.edu>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Spam-Score: -2.6 (--)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "KM" == Kyle Moffett <mrmacman_g4@mac.com> writes:

KM> So does anybody compile userspace under anything other than GCC or
KM> Intel compilers?  Do any such compilers even exist?

PGI and PathScale are around.  Lahey, too, although they seem to just
do Fortran now.

I doubt you'd want to worry about compiling the entire userland with
these compilers, however.

 - J<
