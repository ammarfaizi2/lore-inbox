Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283924AbRLOWLC>; Sat, 15 Dec 2001 17:11:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284009AbRLOWKx>; Sat, 15 Dec 2001 17:10:53 -0500
Received: from fungus.teststation.com ([212.32.186.211]:15630 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S283924AbRLOWKg>; Sat, 15 Dec 2001 17:10:36 -0500
Date: Sat, 15 Dec 2001 23:10:27 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: <puw@cola.teststation.com>
To: Ville Herva <vherva@niksula.hut.fi>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 4GB file size limit on SMBFS
In-Reply-To: <20011215233133.I12063@niksula.cs.hut.fi>
Message-ID: <Pine.LNX.4.33.0112152238280.15938-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Dec 2001, Ville Herva wrote:

> BTW: the fsx test Dave Jones just pointed out pretty quickly fails on smbfs

Yes, I saw that too on a more recent (somewhat modified) kernel. I'm not
very surprised considering it has found flaws in fs' that have a lot more
support.

I will be looking into it, others are welcome to join in the fun :)

/Urban

