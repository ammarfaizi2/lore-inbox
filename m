Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263303AbTC0Q4n>; Thu, 27 Mar 2003 11:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263299AbTC0Q4m>; Thu, 27 Mar 2003 11:56:42 -0500
Received: from 64-238-252-21.arpa.kmcmail.net ([64.238.252.21]:45769 "EHLO
	kermit.unets.com") by vger.kernel.org with ESMTP id <S263303AbTC0Q4k>;
	Thu, 27 Mar 2003 11:56:40 -0500
Subject: Re: Kernel Itself Reports Bug, Continuous OOPS's, and Phantom NIC
	Card
From: Adam Voigt <adam@cryptocomm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1048784675.3228.7.camel@dhcp22.swansea.linux.org.uk>
References: <1048776183.1873.2.camel@beowulf.cryptocomm.com> 
	<1048784675.3228.7.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 27 Mar 2003 12:07:54 -0500
Message-Id: <1048784874.1874.18.camel@beowulf.cryptocomm.com>
Mime-Version: 1.0
X-OriginalArrivalTime: 27 Mar 2003 17:07:54.0646 (UTC) FILETIME=[683C2360:01C2F483]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for responding,

Yes, memtest passes with flying color's.

On Thu, 2003-03-27 at 12:04, Alan Cox wrote:
    On Thu, 2003-03-27 at 14:42, Adam Voigt wrote:
    > Behavior with the OOPS's, is sporatic, I can turn the machine
    > on, wait ten minutes, and log in, and do a "ls" and it will
    > OOPS, other times it will be hours before I see them.
    
    Does it pass things like memtest86
    
    > One other problem, probably unrelated, the BIOS and the Kernel
    > both report seeing a "Realtek 8139" NIC on the computer, though
    > no such card exists and it is not built onto the mobo, only a
    > 3COM 3c59x (PCI Card).
    
    If its seen it will be there somewhere. It may just be integrated
    into something and not actually used by the vendor.
    
-- 
Adam Voigt (adam@cryptocomm.com)
The Cryptocomm Group
My GPG Key: http://64.238.252.49:8080/adam_at_cryptocomm.asc

