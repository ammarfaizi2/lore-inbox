Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbTLWRPW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 12:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbTLWRPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 12:15:22 -0500
Received: from mail1-106.ewetel.de ([212.6.122.106]:42452 "EHLO
	mail1.ewetel.de") by vger.kernel.org with ESMTP id S261850AbTLWRPQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 12:15:16 -0500
Date: Tue, 23 Dec 2003 18:15:12 +0100 (CET)
From: Pascal Schmidt <der.eremit@email.de>
To: Jens Axboe <axboe@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-mm1
In-Reply-To: <20031223170633.GG1601@suse.de>
Message-ID: <Pine.LNX.4.44.0312231813390.3677-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Dec 2003, Jens Axboe wrote:

> > > Pascal, if you could take care of the mode sense check for RO media (see
> > > comment) that would be perfect.
[...]
> Alright, I'll cook it up then.

Much appreciated.

> Yes it will, I don't want to allow write opens on RO media though. It's
> a lot less confusing that way.

Agreed, I'll just have to leave it to you since I don't know how to
implement it.

-- 
Ciao,
Pascal

