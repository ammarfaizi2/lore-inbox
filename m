Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262549AbUCaWqI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 17:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262612AbUCaWqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 17:46:08 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:59619 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S262549AbUCaWpi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 17:45:38 -0500
Date: Thu, 1 Apr 2004 00:45:27 +0200
From: David Weinehall <tao@debian.org>
To: Vincent C Jones <vcjones@NetworkingUnlimited.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.X versus APM Suspend on IBM X23
Message-ID: <20040331224527.GU6041@khan.acc.umu.se>
Mail-Followup-To: Vincent C Jones <vcjones@NetworkingUnlimited.com>,
	linux-kernel@vger.kernel.org
References: <20040331222723.GA6240@NetworkingUnlimited.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040331222723.GA6240@NetworkingUnlimited.com>
User-Agent: Mutt/1.4.1i
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pubkey_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2004 at 05:27:23PM -0500, Vincent C Jones wrote:
> I have found several postings asking about suspend problems on IBM
> thinkpads, but no answers so far. Here is what I have so far:
> 
> Using APM with ACPI and CPUfreq disabled: Suspend works, but only if
> running on battery. When running on AC, I get what sound like PCMCIA
> failure beeps (brief high low), the display goes dark, but the system
> keeps on running and hitting any key brings be right back (at least
> usually, using earlier versions of 2.6 circa .2, the system would
> sometimes lock up after restoring the screen, at which point, sometimes
> C-A-Del or Alt-sysreq-B would work, and sometimes not.)
> 
> FWIW: there were no problems with suspend under any 2.4 kernels. 

I can confirm the exact same behaviour on a Thinkpad A20m.


Regards: David Weinehall
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
