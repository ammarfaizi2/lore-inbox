Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129777AbQKVLKN>; Wed, 22 Nov 2000 06:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130607AbQKVLKE>; Wed, 22 Nov 2000 06:10:04 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:11578 "EHLO
	amsmta03-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S129777AbQKVLJv>; Wed, 22 Nov 2000 06:09:51 -0500
Date: Wed, 22 Nov 2000 12:47:31 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: Keith Owens <kaos@ocs.com.au>
cc: "Jeff V. Merkey" <jmerkey@timpanogas.org>, linux-kernel@vger.kernel.org
Subject: Re: modutils 2.3.20 not backward compatible 
In-Reply-To: <5038.974864798@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.21.0011221247020.26803-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> -i and -m have never been in the base code.  -i in depmod is a Redhat
> add on, only in their distribution.  I have no idea what -m does, apart
> from -m in insmod which is supported.  Blame the distributors.

-m == -F in depmod (RH anyways)


	Igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
