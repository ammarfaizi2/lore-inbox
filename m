Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbTEXOiR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 May 2003 10:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261801AbTEXOiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 May 2003 10:38:17 -0400
Received: from mail.scsiguy.com ([63.229.232.106]:18187 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP id S261780AbTEXOiQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 May 2003 10:38:16 -0400
Date: Sat, 24 May 2003 08:51:11 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: James Bottomley <James.Bottomley@SteelEye.com>,
       Willy Tarreau <willy@w.ods.org>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: Aix7xxx unstable in 2.4.21-rc2? (RE: Linux 2.4.21-rc2)
Message-ID: <156240000.1053787871@aslan.scsiguy.com>
In-Reply-To: <1053786998.1793.31.camel@mulgrave>
References: <1053732598.1951.13.camel@mulgrave> 	<20030524064340.GA1451@alpha.home.local> <1053786998.1793.31.camel@mulgrave>
X-Mailer: Mulberry/3.0.3 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I wish Justin would have proposed a little patch to fix only the locking bugs
>> in -rc1, but honnestly, why should he fix only these bugs when he knows about
>> others that must be fixed too ? I can understand he gives up. -rc is for bug
>> fixes, and his bug fixes are reverted !
> 
> Marcelo reacted exactly as the release committee would at Adaptec:
> either provide the bug fix for assessment or we'll push it out into the
> next release.  This is industry standard practice, so I don't see any
> problem.

Just for clarification.  Marcelo never asked me for a fix.  The only
mail I received from him was an informational message indicating that
the code was being backed out.  If I had been provided an opportunity
to fix the problem, I would have. Considering that the fix has been
available long before RC2 was cut (May 1st.), it's not hard to see that
getting a proper fix required nothing more than just upgrading the driver
or contacting its maintainer to get a paired down fix.

--
Justin

