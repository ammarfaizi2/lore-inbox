Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264082AbUCZQgf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 11:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264076AbUCZQgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 11:36:35 -0500
Received: from mx1.redhat.com ([66.187.233.31]:64974 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264083AbUCZQgZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 11:36:25 -0500
Date: Fri, 26 Mar 2004 11:36:15 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Clay Haapala <chaapala@cisco.com>
cc: Jouni Malinen <jkmaline@cc.hut.fi>, "David S. Miller" <davem@redhat.com>,
       <linux-kernel@vger.kernel.org>, <Matt_Domsch@dell.com>
Subject: Re: [PATCH] lib/libcrc32c implementation
In-Reply-To: <yqujptb4ltc9.fsf@chaapala-lnx2.cisco.com>
Message-ID: <Xine.LNX.4.44.0403261134210.4331-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Mar 2004, Clay Haapala wrote:

> This patch agains 2.6.4 kernel code implements the CRC32C algorithm.
> The routines are based on the same design as the existing CRC32 code.
> Licensing is intended to be identical (GPL).

These need to be rediffed against the latest Linus kernel.

It may be better to wait until 2.6.5 comes out, so we don't have too much 
new stuff going into the -rc kernels.


- James
-- 
James Morris
<jmorris@redhat.com>


