Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263366AbSLTSDa>; Fri, 20 Dec 2002 13:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263321AbSLTSDa>; Fri, 20 Dec 2002 13:03:30 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:49924 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S263366AbSLTSD3>; Fri, 20 Dec 2002 13:03:29 -0500
Date: Fri, 20 Dec 2002 18:11:32 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: mdew <mdew@orcon.net.nz>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Bug? undefined reference to `input_event'
In-Reply-To: <1040336538.7886.8.camel@nirvana>
Message-ID: <Pine.LNX.4.44.0212201810290.6471-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> in both the 2.5.52, and bitkeeper trees, i get this error with make
> bzImage.

Ug. Not the VT input dependency bug again. There is a fix for that.
Vojtech do you want me to push those changes I pushed your way some time 
ago?



