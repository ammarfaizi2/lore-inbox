Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932327AbVHKUFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbVHKUFF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 16:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbVHKUFE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 16:05:04 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:41408 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932327AbVHKUFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 16:05:03 -0400
Subject: Re: Need help in understanding x86 syscall
From: Steven Rostedt <rostedt@goodmis.org>
To: Zachary Amsden <zach@vmware.com>
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Coywolf Qi Hunt <coywolf@gmail.com>, 7eggert@gmx.de,
       Ukil a <ukil_a@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <42FBADDF.1020700@vmware.com>
References: <4Ae73-6Mm-5@gated-at.bofh.it> <E1E3DJm-0000jy-0B@be1.lrz>
	 <Pine.LNX.4.61.0508110954360.14541@chaos.analogic.com>
	 <1123770661.17269.59.camel@localhost.localdomain>
	 <2cd57c90050811081374d7c4ef@mail.gmail.com>
	 <Pine.LNX.4.61.0508111124530.14789@chaos.analogic.com>
	 <1123775508.17269.64.camel@localhost.localdomain>
	 <1123777184.17269.67.camel@localhost.localdomain>
	 <2cd57c90050811093112a57982@mail.gmail.com>
	 <2cd57c9005081109597b18cc54@mail.gmail.com>
	 <Pine.LNX.4.61.0508111310180.15153@chaos.analogic.com>
	 <1123781187.17269.77.camel@localhost.localdomain>
	 <1123781639.17269.83.camel@localhost.localdomain>
	 <42FB91FA.7070104@vmware.com>
	 <1123784248.17269.93.camel@localhost.localdomain>
	 <42FBADDF.1020700@vmware.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 11 Aug 2005 16:04:52 -0400
Message-Id: <1123790692.17269.114.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-11 at 12:58 -0700, Zachary Amsden wrote:

> If you're feeling really masochistic, I've added a demonstration of how 
> you can call sysenter from userspace without glibc. 

Thanks Zach, this will give me something to play around with when I have
a little more spare time >8-}

-- Steve


