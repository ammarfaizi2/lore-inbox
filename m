Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261203AbVBLUwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbVBLUwZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 15:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261201AbVBLUwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 15:52:25 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:44958 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261171AbVBLUwQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 15:52:16 -0500
Date: Sat, 12 Feb 2005 12:51:51 -0800
From: Paul Jackson <pj@sgi.com>
To: Andi Kleen <ak@suse.de>
Cc: arjan@infradead.org, raybry@sgi.com, taka@valinux.co.jp, hugh@veritas.com,
       akpm@osdl.org, haveblue@us.ibm.com, marcello@cyclades.com,
       raybry@austin.rr.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 2.6.11-rc2-mm2 7/7] mm: manual page migration --
 sys_page_migrate
Message-Id: <20050212125151.57033c06.pj@sgi.com>
In-Reply-To: <20050212144835.GC16075@wotan.suse.de>
References: <20050212032535.18524.12046.26397@tomahawk.engr.sgi.com>
	<20050212032620.18524.15178.29731@tomahawk.engr.sgi.com>
	<1108211672.4056.10.camel@localhost.localdomain>
	<20050212144835.GC16075@wotan.suse.de>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi wrote:
> They're already exposed through mbind/set_mempolicy/get_mempolicy and sysfs
> of course.

And soon I hope through cpusets ;).

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.650.933.1373, 1.925.600.0401
