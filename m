Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262884AbTIFQod (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 12:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262903AbTIFQod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 12:44:33 -0400
Received: from [144.139.59.128] ([144.139.59.128]:33152 "EHLO
	excalibur.intercode.com.au") by vger.kernel.org with ESMTP
	id S262884AbTIFQoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 12:44:32 -0400
Date: Sun, 7 Sep 2003 02:43:31 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Erlend Aasland <erlend-a@ux.his.no>
cc: "David S. Miller" <davem@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [CRYPTO] add alg. type to /proc/crypto output
In-Reply-To: <20030906100818.GA24931@johanna5.ux.his.no>
Message-ID: <Mutt.LNX.4.44.0309070238240.12253-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Sep 2003, Erlend Aasland wrote:

> On 09/05/03 07:34, David S. Miller wrote:
> > Is it even useful?
> Check http://samba.org/~jamesm/crypto/TODO
> It's listed under medium priority, so I thought I was doing a good
> thing implementing it.

I think someone asked for it once, not sure exactly why, but I guess it
makes parsing simpler and theoretically less likely to break if e.g. a
field is added or removed for an algorithm type.


- James
-- 
James Morris
<jmorris@intercode.com.au>

