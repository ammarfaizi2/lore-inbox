Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131630AbRC0VfH>; Tue, 27 Mar 2001 16:35:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131631AbRC0Ve5>; Tue, 27 Mar 2001 16:34:57 -0500
Received: from vp175062.reshsg.uci.edu ([128.195.175.62]:2308 "EHLO
	moisil.dev.hydraweb.com") by vger.kernel.org with ESMTP
	id <S131630AbRC0Vet>; Tue, 27 Mar 2001 16:34:49 -0500
Date: Tue, 27 Mar 2001 13:34:06 -0800
Message-Id: <200103272134.f2RLY6801637@moisil.dev.hydraweb.com>
From: Ion Badulescu <ionut@moisil.cs.columbia.edu>
To: Jun Sun <jsun@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: eepro100 question: why SCBCmd byte is 0x80?
In-Reply-To: <3ABB892C.A47D6BA9@mvista.com>
User-Agent: tin/1.5.7-20001104 ("Paradise Regained") (UNIX) (Linux/2.2.19 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Mar 2001 09:34:36 -0800, Jun Sun <jsun@mvista.com> wrote:

> BTW, does the eepro100 patch for 2.2.19pre apply to 2.4.2?  Or it is already
> in it?

It was backported from 2.4.1, so yes, it's already in.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
