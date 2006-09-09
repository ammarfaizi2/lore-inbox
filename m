Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964992AbWIIXHS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964992AbWIIXHS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 19:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964993AbWIIXHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 19:07:17 -0400
Received: from gw.goop.org ([64.81.55.164]:54964 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S964992AbWIIXHQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 19:07:16 -0400
Message-ID: <4503491F.6080101@goop.org>
Date: Sat, 09 Sep 2006 16:07:11 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060907)
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386-pda updates
References: <45027822.2010906@goop.org> <20060909155257.GA50136@muc.de>
In-Reply-To: <20060909155257.GA50136@muc.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> I think i would prefer to merge that and the 1 byte one only
> with actual users (x86-64 hasn't needed either for a long time)

Taking the address of a PDA field is pretty useful.  And it is going to 
be important for a subsequent patch.

    J

