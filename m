Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbTHTDPp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 23:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261588AbTHTDPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 23:15:45 -0400
Received: from mta05-svc.ntlworld.com ([62.253.162.45]:39810 "EHLO
	mta05-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S261561AbTHTDPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 23:15:44 -0400
Subject: Re: 2.6.0-test3-mm3
From: Jonathan Brown <jbrown@emergence.uk.net>
To: Andrew Morton <akpm@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
In-Reply-To: <20030819013834.1fa487dc.akpm@osdl.org>
References: <20030819013834.1fa487dc.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1061349342.8327.11.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 20 Aug 2003 04:15:43 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  CC      arch/i386/kernel/mpparse.o
arch/i386/kernel/mpparse.c: In function `mp_config_ioapic_for_sci':
arch/i386/kernel/mpparse.c:1067: warning: implicit declaration of
function `mp_find_ioapic'
arch/i386/kernel/mpparse.c:1069: `mp_ioapic_routing' undeclared (first
use in this function)
arch/i386/kernel/mpparse.c:1069: (Each undeclared identifier is reported
only once
arch/i386/kernel/mpparse.c:1069: for each function it appears in.)
arch/i386/kernel/mpparse.c:1071: warning: implicit declaration of
function `io_apic_set_pci_routing'
arch/i386/kernel/mpparse.c: In function `mp_parse_prt':
arch/i386/kernel/mpparse.c:1115: `mp_ioapic_routing' undeclared (first
use in this function)
make[1]: *** [arch/i386/kernel/mpparse.o] Error 1
make: *** [arch/i386/kernel] Error 2


