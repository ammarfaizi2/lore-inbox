Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263904AbTJFAEq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 20:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263905AbTJFAEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 20:04:46 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:10687 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S263904AbTJFAEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 20:04:45 -0400
Date: Mon, 6 Oct 2003 02:04:26 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Justin Hibbits <jrh29@po.cwru.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG in 2.4.xx
Message-ID: <20031006000426.GA26857@louise.pinerecords.com>
References: <83C51710-F764-11D7-BAB4-000A95841F44@po.cwru.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83C51710-F764-11D7-BAB4-000A95841F44@po.cwru.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct-05 2003, Sun, 14:48 -0400
Justin Hibbits <jrh29@po.cwru.edu> wrote:

> (panic from 2.4.22, but panics also in 2.4.21)
> 
> This is what I get when I have high memory support and preempt enabled 
> in any 2.4 kernel.  High mem set to 4GB.  If I disable preempt, all 
> works just fine.  If you need more help, I'll keep this kernel around.

Preempt code is not officially part of the kernel.org 2.4 kernel
series, you need to take this up with the maintainer of the patchset
you're using.

-- 
Tomas Szepe <szepe@pinerecords.com>
