Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263317AbTC3BnB>; Sat, 29 Mar 2003 20:43:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263357AbTC3BnB>; Sat, 29 Mar 2003 20:43:01 -0500
Received: from cerebus.wirex.com ([65.102.14.138]:56315 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S263317AbTC3BnA>; Sat, 29 Mar 2003 20:43:00 -0500
Date: Sat, 29 Mar 2003 17:52:09 -0800
From: Chris Wright <chris@wirex.com>
To: Shaya Potter <spotter@yucs.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: process creation/deletions hooks
Message-ID: <20030329175208.A28410@figure1.int.wirex.com>
Mail-Followup-To: Shaya Potter <spotter@yucs.org>,
	linux-kernel@vger.kernel.org
References: <1048799290.31010.62.camel@zaphod> <20030328180303.A26128@figure1.int.wirex.com> <1048989040.32227.126.camel@zaphod>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1048989040.32227.126.camel@zaphod>; from spotter@yucs.org on Sat, Mar 29, 2003 at 08:50:42PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Shaya Potter (spotter@yucs.org) wrote:
> would that be task_alloc_security() and task_free_security()?

yes, exactly.
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
