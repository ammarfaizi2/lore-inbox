Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263059AbTC1RFA>; Fri, 28 Mar 2003 12:05:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263063AbTC1RFA>; Fri, 28 Mar 2003 12:05:00 -0500
Received: from [81.2.110.254] ([81.2.110.254]:41724 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id <S263059AbTC1RE7>;
	Fri, 28 Mar 2003 12:04:59 -0500
Subject: Re: hdparm and removable IDE?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ron House <house@usq.edu.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E83BB8E.6050303@usq.edu.au>
References: <3E812F8E.2030200@usq.edu.au>
	 <1048689184.31839.7.camel@irongate.swansea.linux.org.uk>
	 <3E83BB8E.6050303@usq.edu.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048871860.5055.37.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 28 Mar 2003 17:17:40 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-03-28 at 03:03, Ron House wrote:
> Thanks Alan. What is needed to do this? Is umounting and then 
> unregistering with hdparm -U enough to do this, or is something else needed?

If the hardware can do it then most of the time yes. Just very very
occasionally it might blow up in your face, but thats stuff which is
going to take a lot of fixing and wont get fixed for 2.4 I fear

