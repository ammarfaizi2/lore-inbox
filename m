Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbTEFXfl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 19:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261832AbTEFXfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 19:35:41 -0400
Received: from smtp-out.comcast.net ([24.153.64.116]:58230 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S261279AbTEFXfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 19:35:40 -0400
Date: Tue, 06 May 2003 19:48:04 -0400
From: Matthew Harrell <lists-sender-14a37a@bittwiddlers.com>
Subject: Re: [FIXED 2.5.69] Re: [2.5.67 - 2.5.68] Hangs on pcmcia yenta_socket
	initialisation
In-reply-to: <200305051051.09629.devilkin-lkml@blindguardian.org>
To: DevilKin <devilkin-lkml@blindguardian.org>
Cc: Kernel List <linux-kernel@vger.kernel.org>
Reply-to: Matthew Harrell 
	  <mharrell-dated-1052696888.67fff1@bittwiddlers.com>
Message-id: <20030506234804.GA22226@bittwiddlers.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.5.4i
X-Delivery-Agent: TMDA/0.75 (Ponder)
X-Primary-Address: mharrell@bittwiddlers.com
References: <200304230747.27579.devilkin-lkml@blindguardian.org>
 <200304240940.21553.devilkin-lkml@blindguardian.org>
 <20030424085756.A9597@flint.arm.linux.org.uk>
 <200305051051.09629.devilkin-lkml@blindguardian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Was this one you reported - I didn't see this one.  

I still get a hang on any 2.5.50+ kernel when I load yenta and have ACPI
turned on.  It locks solid about three seconds after loading the module


> 
> Just reporting that this now works fine under 2.5.69. Whatever the problem, 
> it's definitely gone now.
> 

-- 
  Matthew Harrell                          Preserve wildlife --
  Bit Twiddlers, Inc.                       pickle a squirrel today!
  mharrell@bittwiddlers.com     
