Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262293AbUD2A7v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262293AbUD2A7v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 20:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262351AbUD2A7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 20:59:50 -0400
Received: from florence.buici.com ([206.124.142.26]:62341 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S262293AbUD2A6C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 20:58:02 -0400
Date: Wed, 28 Apr 2004 17:58:01 -0700
From: Marc Singer <elf@buici.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       brettspamacct@fastclick.com, linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
Message-ID: <20040429005801.GA21978@buici.com>
References: <409021D3.4060305@fastclick.com> <20040428170106.122fd94e.akpm@osdl.org> <409047E6.5000505@pobox.com> <40904A84.2030307@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40904A84.2030307@yahoo.com.au>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2004 at 10:21:24AM +1000, Nick Piggin wrote:
> Anyway, I have a small set of VM patches which attempt to improve
> this sort of behaviour if anyone is brave enough to try them.
> Against -mm kernels only I'm afraid (the objrmap work causes some
> porting difficulty).

Is this the same patch you wanted me to try?  

  Remember, the embedded system where NFS IO was pushing my
  application out of memory.  Setting swappiness to zero was a
  temporary fix.


