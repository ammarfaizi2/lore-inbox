Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277192AbRJLLPs>; Fri, 12 Oct 2001 07:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277622AbRJLLP3>; Fri, 12 Oct 2001 07:15:29 -0400
Received: from genesis.westend.com ([212.117.67.2]:43406 "EHLO
	genesis.westend.com") by vger.kernel.org with ESMTP
	id <S277256AbRJLLPQ>; Fri, 12 Oct 2001 07:15:16 -0400
Date: Fri, 12 Oct 2001 13:15:37 +0200
From: Christian Hammers <ch@westend.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: solved: 2.4.10 and 2GB memory allocation problems
Message-ID: <20011012131537.C14194@westend.com>
In-Reply-To: <20011009153503.H17011@westend.com> <Pine.LNX.4.21.0110091015590.5604-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.21.0110091015590.5604-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Tue, Oct 09, 2001 at 10:17:54AM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On Tue, Oct 09, 2001 at 10:17:54AM -0200, Marcelo Tosatti wrote:
> On Tue, 9 Oct 2001, Christian Hammers wrote:
> > I got problems with linux kernel 2.4.10 and 2GB ram with 4GB-Highmem
> > support enabled:
> > 	__alloc_pages: 0-order allocation failed (gfp=0xf0/0) from c012e4be
> > (hundret times and then all my apaches where in "D" mode in "ps faxu" and
> > I had to reboot the machine.
> 2.4.11pre6 already includes this patch and other fixes from Andrea which
> should get rid of the failed allocations problem.
> Could you please try pre6 and report results?

I'm using -pre6 since a couple of days now and got no problems. Thanks!

bye,

 -christian-

-- 
Christian Hammers    WESTEND GmbH - Aachen und Dueren     Tel 0241/701333-0
ch@westend.com     Internet & Security for Professionals    Fax 0241/911879
           WESTEND ist CISCO Systems Partner - Premium Certified
