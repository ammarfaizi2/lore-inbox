Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263497AbTC3Bu6>; Sat, 29 Mar 2003 20:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263498AbTC3Bu6>; Sat, 29 Mar 2003 20:50:58 -0500
Received: from cs.columbia.edu ([128.59.16.20]:36521 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S263497AbTC3Bu4>;
	Sat, 29 Mar 2003 20:50:56 -0500
Subject: Re: process creation/deletions hooks
From: Shaya Potter <spotter@yucs.org>
To: Chris Wright <chris@wirex.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030329175208.A28410@figure1.int.wirex.com>
References: <1048799290.31010.62.camel@zaphod>
	 <20030328180303.A26128@figure1.int.wirex.com>
	 <1048989040.32227.126.camel@zaphod>
	 <20030329175208.A28410@figure1.int.wirex.com>
Content-Type: text/plain
Organization: 
Message-Id: <1048989675.32227.128.camel@zaphod>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 29 Mar 2003 21:01:15 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the main issue w/ this is that this doesn't support multiple things
using the hooks.

On Sat, 2003-03-29 at 20:52, Chris Wright wrote:
> * Shaya Potter (spotter@yucs.org) wrote:
> > would that be task_alloc_security() and task_free_security()?
> 
> yes, exactly.
> -chris

