Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263823AbUFKLeb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263823AbUFKLeb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 07:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263824AbUFKLeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 07:34:31 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:46291 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263823AbUFKLe3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 07:34:29 -0400
Date: Fri, 11 Jun 2004 04:32:57 -0700
From: Paul Jackson <pj@sgi.com>
To: Andi Kleen <ak@muc.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc3-mm1
Message-Id: <20040611043257.1aa415d3.pj@sgi.com>
In-Reply-To: <m3r7sm5q0u.fsf@averell.firstfloor.org>
References: <2576k-4hW-13@gated-at.bofh.it>
	<25LZK-88C-17@gated-at.bofh.it>
	<m3r7sm5q0u.fsf@averell.firstfloor.org>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi wrote:
> Paul Jackson <pj@sgi.com> writes:
> >
> > Uninlining find_first_bit() reduces my i386 kernel text size by 1336 bytes.
> 
> Sounds attractive.

It's fine by me if you push it for i386 as well.  Or not.

My current focus is elsewhere.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
