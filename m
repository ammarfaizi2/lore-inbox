Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264731AbUFSWoy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264731AbUFSWoy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 18:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264746AbUFSWoy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 18:44:54 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:30603 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S264731AbUFSWox
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 18:44:53 -0400
Date: Sun, 20 Jun 2004 00:44:28 +0200
From: Frank van Maarseveen <frankvm@xs4all.nl>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Andrew Morton <akpm@osdl.org>, sdake@mvista.com, liste@jordet.nu,
       linux-kernel@vger.kernel.org, sct@redhat.com
Subject: Re: [2.4] page->buffers vanished in journal_try_to_free_buffers()
Message-ID: <20040619224428.GA7713@janus>
Mail-Followup-To: Frank van Maarseveen <frankvm@xs4all.nl>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Andrew Morton <akpm@osdl.org>, sdake@mvista.com, liste@jordet.nu,
	linux-kernel@vger.kernel.org, sct@redhat.com
References: <Pine.LNX.4.58L.0402052139420.16422@logos.cnet> <1078225389.931.3.camel@buick.jordet> <1087232825.28043.4.camel@persist.az.mvista.com> <20040615131650.GA13697@logos.cnet> <1087322198.8117.10.camel@persist.az.mvista.com> <20040617131600.GB3029@logos.cnet> <20040617200859.7fada9fe.akpm@osdl.org> <20040619194849.GA2843@logos.cnet> <20040619195013.GA6672@janus> <20040619221711.GA2287@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040619221711.GA2287@logos.cnet>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 19, 2004 at 07:17:11PM -0300, Marcelo Tosatti wrote:
> 
> Has the oops happened again? What kernel are you running now?

no new oopses.

The machine has used 2.4.21 for a while, then 2.4.25 and now 2.4.26. The
problem _seems_ to show up here only in 2.4.22, 2.4.23 and 2.4.24.



-- 
Frank
