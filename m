Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265974AbTGDKvi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 06:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265975AbTGDKvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 06:51:38 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:42503 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S265974AbTGDKvh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 06:51:37 -0400
Message-ID: <3F05610C.4050202@aitel.hist.no>
Date: Fri, 04 Jul 2003 13:12:12 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.74-mm1 fails to boot due to APIC trouble, 2.5.73mm3 works.
References: <20030703023714.55d13934.akpm@osdl.org> <3F054109.2050100@aitel.hist.no> <20030704093531.GA26348@holomorphy.com> <20030704095004.GB26348@holomorphy.com> <20030704100217.GC26348@holomorphy.com> <20030704100749.GD26348@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I applied both of your recent patches, and the patched
2.5.74-mm1 kernel came up fine. :-)


ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
  IO-APIC (apicid-pin) 2-0, 2-5, 2-9, 2-11, 2-17, 2-19 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 22.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................


Helge Hafting

