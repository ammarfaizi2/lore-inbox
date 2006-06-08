Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbWFHKXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbWFHKXM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 06:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932116AbWFHKXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 06:23:12 -0400
Received: from aun.it.uu.se ([130.238.12.36]:23169 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S932112AbWFHKXL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 06:23:11 -0400
Date: Thu, 8 Jun 2006 12:23:05 +0200 (MEST)
Message-Id: <200606081023.k58AN5Ia026206@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: linux-kernel@vger.kernel.org, rajeevm@subextechnologies.com
Subject: Re: Problem related to Red Hat Linux kernel 2.6.9-5.EL
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Jun 2006 14:30:21 +0550, Rajeev Majumdar wrote:
> I  have  a problem  with  kernel  2.6.9-5. EL  that  is enterprise
>version of Red Hat linux. I am trying to run 500 or more processes
>parallely with TETware distributed test harness (that can schedule processes
>parallely and using its synchronisizing mechanism) but after running for
>some time some processes get stuck at futex system call and waiting
>infinetly that i found with strace utility.

That kernel is ancient: upgrade to 2.6.9-34.0.1.EL and try again.
If the problem persists, report it to RedHat. This mailing list
(linux-kernel) is about the standard kernel, not vendor-specific ones.
