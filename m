Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751280AbWDERBS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbWDERBS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 13:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbWDERBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 13:01:18 -0400
Received: from mx.pathscale.com ([64.160.42.68]:4507 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751280AbWDERBR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 13:01:17 -0400
Subject: Re: [OT] Non-GCC compilers used for linux userspace
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Jason L Tibbitts III <tibbs@math.uh.edu>,
       Eric Piel <Eric.Piel@tremplin-utc.net>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, Rob Landley <rob@landley.net>,
       nix@esperi.org.uk, mmazur@kernel.pl, linux-kernel@vger.kernel.org,
       llh-discuss@lists.pld-linux.org
In-Reply-To: <54199D84-7DB7-434E-BA83-9B2658182124@mac.com>
References: <200603141619.36609.mmazur@kernel.pl>
	 <20060326065205.d691539c.mrmacman_g4@mac.com>
	 <4426A5BF.2080804@tremplin-utc.net> <200603261609.10992.rob@landley.net>
	 <44271E88.6040101@tremplin-utc.net>
	 <5DC72207-3C0B-44C2-A9E5-319C0A965E9D@mac.com>
	 <Pine.LNX.4.61.0603281619300.27529@yvahk01.tjqt.qr>
	 <36A8C3CC-3E4D-4158-AABB-F4D2C66AA8CD@mac.com>
	 <442960B6.2040502@tremplin-utc.net>
	 <7E2F0C3C-4091-4EEB-8E10-C1F58F94BD59@mac.com>
	 <ufazmjaec9q.fsf@epithumia.math.uh.edu>
	 <54199D84-7DB7-434E-BA83-9B2658182124@mac.com>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Wed, 05 Apr 2006 10:01:12 -0700
Message-Id: <1144256472.3984.7.camel@chalcedony.internal.keyresearch.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-28 at 12:13 -0500, Kyle Moffett wrote:

> Mainly I want to know if I should even bother making the kabi headers  
> compile with anything other than GCC.

The PathScale compiler is gcc-compatible, so there should be no problems
for us using gcc-isms in those headers.

	<b

