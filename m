Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265592AbUA0UO5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 15:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265595AbUA0UO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 15:14:56 -0500
Received: from mx1.redhat.com ([66.187.233.31]:21894 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265592AbUA0UOz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 15:14:55 -0500
Date: Tue, 27 Jan 2004 15:14:53 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Jean-Luc Cooke <jlcooke@certainkey.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto/sha256.c crypto/sha512.c
In-Reply-To: <20040127193945.GA15559@certainkey.com>
Message-ID: <Xine.LNX.4.44.0401271514150.4185-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jan 2004, Jean-Luc Cooke wrote:

> Optimized the choice and majority fuctions a bit.
> 
> Patch:
>   http://jlcooke.ca/lkml/faster_sha2.patch
> 
> Test suite:
>   http://jlcooke.ca/lkml/faster_sha2.c
>   build with:
>     gcc -O3 -s faster_sha2.c -o faster_sha2
> 

What kind of performance improvement does this provide?


- James
-- 
James Morris
<jmorris@redhat.com>


