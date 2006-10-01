Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbWJARbo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbWJARbo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 13:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbWJARbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 13:31:44 -0400
Received: from gw.goop.org ([64.81.55.164]:53186 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S932100AbWJARbn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 13:31:43 -0400
Message-ID: <451FFB7E.1090609@goop.org>
Date: Sun, 01 Oct 2006 10:31:42 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: x86 BUG bug
References: <451FA997.9050000@garzik.org>
In-Reply-To: <451FA997.9050000@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Being rusty on the gcc asm syntax -- does an inline asm statement 
> permit 'noreturn'? -- I figured it would be best just to report this, 
> rather than create a patch myself. 

I'm reworking BUG at the moment, and I noticed this as well.  I'll try 
to fix it.

    J
