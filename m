Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262509AbTCMTjI>; Thu, 13 Mar 2003 14:39:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262512AbTCMTjI>; Thu, 13 Mar 2003 14:39:08 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:53509 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S262509AbTCMTjH>;
	Thu, 13 Mar 2003 14:39:07 -0500
Date: Thu, 13 Mar 2003 20:48:49 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: Patch for initrd on 2.4.21-pre5
Message-ID: <20030313194849.GB679@alpha.home.local>
References: <20030313005328.A29160@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030313005328.A29160@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 13, 2003 at 12:53:28AM -0500, Pete Zaitcev wrote:
> The initrd refuses to work for me without the attached patch
> (actually, initrd works, but nothing else does: console is hosed).
> I did not see anything on the list. Am I the only one who
> uses initrd?

Hello Pete,

the same patch was send on 22 Jan by Russell Coker, but apparently got ignored.
Perhaps other people are used to only use patched 2.4.21pre kernels.

Cheers,
Willy

