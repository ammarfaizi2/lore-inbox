Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbUAIQ3y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 11:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261953AbUAIQ3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 11:29:54 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:14461 "EHLO
	thoron.boston.redhat.com") by vger.kernel.org with ESMTP
	id S261889AbUAIQ3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 11:29:52 -0500
Date: Fri, 9 Jan 2004 11:29:50 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Raj <obelix123@toughguy.net>
cc: Joilnen Leite <pidhash@yahoo.com>, <linux-net@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>, <davem@redhat.com>
Subject: Re: about ipmr
In-Reply-To: <3FFE4D23.5030400@toughguy.net>
Message-ID: <Xine.LNX.4.44.0401091129360.21620-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Jan 2004, Raj wrote:

> I would prefer this way of checking the NULL
> 
> That would be more consistent with ip_gre.c and ipip.c
> 
> any suggestions ?

Yes, this is much better form.


- James
-- 
James Morris
<jmorris@redhat.com>


