Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271055AbTHCHhU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 03:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271063AbTHCHhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 03:37:20 -0400
Received: from baloney.puettmann.net ([194.97.54.34]:53714 "EHLO
	baloney.puettmann.net") by vger.kernel.org with ESMTP
	id S271055AbTHCHhT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 03:37:19 -0400
Date: Sun, 3 Aug 2003 09:36:29 +0200
To: Willy Tarreau <willy@w.ods.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ACPI Error with 2.4.20-pre10 on ibm thinkpad
Message-ID: <20030803073629.GA17197@puettmann.net>
References: <20030803002438.GA15097@puettmann.net> <20030803073115.GC679@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20030803073115.GC679@alpha.home.local>
User-Agent: Mutt/1.5.4i
From: Ruben Puettmann <ruben@puettmann.net>
X-Scanner: exiscan *19jDPp-0004Tf-00*oHAP6b11E7Y* (Puettmann.NeT, Germany)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 03, 2003 at 09:31:15AM +0200, Willy Tarreau wrote:
> On Sun, Aug 03, 2003 at 02:24:38AM +0200, Ruben Puettmann wrote:
> > Local APIC disabled by BIOS -- reenabling.
> > Found and enabled local APIC!
> 
> ACPI on my VAIO was a bit jerky until I disabled local APIC. It now seems to
> work OK. BTW, this notebook would never reboot with local APIC ON ! The BIOS
> cannot access the hard disk anymore.
> 
> Even if they're not the same systems, perhaps you should try to disable APIC
> on your thinkpad ?
> 
Apic runs very fine also apm only acpi makes trouble with ac battery an
thermal. Processor runs very fine to ( all states are Yes).



            ruben 

-- 
Ruben Puettmann
ruben@puettmann.net
http://www.puettmann.net
