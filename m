Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267263AbUG2IvK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267263AbUG2IvK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 04:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267302AbUG2IvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 04:51:10 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:3715 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267263AbUG2IuU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 04:50:20 -0400
Date: Thu, 29 Jul 2004 01:49:40 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: peter@chubb.wattle.id.au, viro@parcelfarce.linux.theplanet.co.uk,
       davem@redhat.com, cw@f00f.org, linux-kernel@vger.kernel.org
Subject: Re: stat very inefficient
Message-Id: <20040729014940.7f1e3315.pj@sgi.com>
In-Reply-To: <20040729004242.7601f777.akpm@osdl.org>
References: <233602095@toto.iv>
	<16648.10711.200049.616183@wombat.chubb.wattle.id.au>
	<20040728154523.20713ef1.davem@redhat.com>
	<20040729000837.GA24956@taniwha.stupidest.org>
	<20040728171414.5de8da96.davem@redhat.com>
	<20040729002924.GK12308@parcelfarce.linux.theplanet.co.uk>
	<16648.42669.907048.112765@wombat.chubb.wattle.id.au>
	<20040729004242.7601f777.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:
> hmm.  Here's a Pentium III profile ...

What conclusion do your draw from this profile?

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
