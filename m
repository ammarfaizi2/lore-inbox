Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277072AbRJKXn4>; Thu, 11 Oct 2001 19:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277073AbRJKXng>; Thu, 11 Oct 2001 19:43:36 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:22268 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S277072AbRJKXn3>;
	Thu, 11 Oct 2001 19:43:29 -0400
Date: Thu, 11 Oct 2001 19:43:59 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Stephan von Krawczynski <skraw@ithnet.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Partitioning problems in 2.4.11
In-Reply-To: <20011012013421.5ede2ab1.skraw@ithnet.com>
Message-ID: <Pine.GSO.4.21.0110111943090.24742-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 12 Oct 2001, Stephan von Krawczynski wrote:

> Hi Alexander,
> 
> just a short comment: I got a host with PIII-500 and the same problem. A
> partition on primary IDE (single partition for whole drive) vanished during use
> of 2.4.10(SuSE 7.3)/11. System works flawlessly otherwise. It is booting from
> SCSI, ide was only data :-). It has 384 MB RAM.

Try the patch against 2.4.13-pre1 posted in that thread.

