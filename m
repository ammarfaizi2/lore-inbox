Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751836AbWJHAV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751836AbWJHAV7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 20:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751838AbWJHAV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 20:21:59 -0400
Received: from gw.goop.org ([64.81.55.164]:8070 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751836AbWJHAV6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 20:21:58 -0400
Message-ID: <452844AB.2050406@goop.org>
Date: Sat, 07 Oct 2006 17:22:03 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20061004)
MIME-Version: 1.0
To: David Wagner <daw-usenet@taverner.cs.berkeley.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: Really good idea to allow mmap(0, FIXED)?
References: <200610052059.11714.mb@bu3sch.de> <eg4624$be$1@taverner.cs.berkeley.edu> <1160119515.3000.89.camel@laptopd505.fenrus.org> <eg6bk4$7r1$1@taverner.cs.berkeley.edu>
In-Reply-To: <eg6bk4$7r1$1@taverner.cs.berkeley.edu>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Wagner wrote:
> Oops.  Please ignore the PROT_EXEC.  That is completely irrelevant.
> I'm sorry I included it; the inclusion of PROT_EXEC was a mistake.
> Delete PROT_EXEC, then re-read my email -- everything else in there is
> still valid.
>   
Though (*something_ops->thingy)() becomes a lot more interesting if 
something_ops or ->thingy is NULL...

    J
