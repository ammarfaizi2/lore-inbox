Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289712AbSAOWzK>; Tue, 15 Jan 2002 17:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289725AbSAOWy6>; Tue, 15 Jan 2002 17:54:58 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:46090 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S289712AbSAOWyp>; Tue, 15 Jan 2002 17:54:45 -0500
Date: Tue, 15 Jan 2002 19:41:54 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Mostly PAGE_SIZE IO for RAW (FINAL VERSION)
In-Reply-To: <200201142211.g0EMBPa09047@eng2.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.21.0201151930560.27118-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 14 Jan 2002, Badari Pulavarty wrote:

> 
> Here is the final version of the patch for doing mostly 4K size IO
> for RAW. (2.4.17). In this version, I incorporate all the code 
> review comments from Andrea. Thanks to Andrea.
> 
> Marcelo, would you please consider this patch for 2.4.18-pre4 ?
> Please let me know, if you want me to make the patch for 2.4.18-pre3. 

I want to make sure the drivers able to do 4K IO really can do that with
reliability.

I think we can test that on -ac kernels. 

