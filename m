Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264010AbSLEJH6>; Thu, 5 Dec 2002 04:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264625AbSLEJH5>; Thu, 5 Dec 2002 04:07:57 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:63223 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S264010AbSLEJH5>; Thu, 5 Dec 2002 04:07:57 -0500
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20021204222039.A12956@flint.arm.linux.org.uk> 
References: <20021204222039.A12956@flint.arm.linux.org.uk>  <200212030724.gB37O4DL001318@turing-police.cc.vt.edu> <20021203121521.GB30431@suse.de> <20021204115819.GB1137@gallifrey> <20021204124227.GB647@suse.de> <20021204183235.GA701@gallifrey> 
To: Russell King <rmk@arm.linux.org.uk>
Cc: "Dr. David Alan Gilbert" <gilbertd@treblig.org>,
       Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: lkml, bugme.osdl.org? 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 05 Dec 2002 09:15:18 +0000
Message-ID: <3536.1039079718@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


rmk@arm.linux.org.uk said:
>  Oh, not to mention the inherently racy code found within mm/vmalloc.c

A fix for that was sent to Linus months ago. Akpm says it breaks, nobody 
else can reproduce the breakage and I can't see a problem with it...

--
dwmw2


