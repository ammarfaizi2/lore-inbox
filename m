Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271670AbSISQw2>; Thu, 19 Sep 2002 12:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271691AbSISQw2>; Thu, 19 Sep 2002 12:52:28 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:22679 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S271670AbSISQw1>; Thu, 19 Sep 2002 12:52:27 -0400
From: Badari Pulavarty <pbadari@us.ibm.com>
Message-Id: <200209191657.g8JGvHC10694@eng2.beaverton.ibm.com>
Subject: Re: /dev/null broken in 2.5.36 ?
To: riel@conectiva.com.br (Rik van Riel)
Date: Thu, 19 Sep 2002 09:57:17 -0700 (PDT)
Cc: pbadari@us.ibm.com (Badari Pulavarty), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44L.0209191355000.1519-100000@duckman.distro.conectiva> from "Rik van Riel" at Sep 19, 2002 12:55:32 PM PST
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Thu, 19 Sep 2002, Badari Pulavarty wrote:
> 
> > As you can from strace output, read on /dev/null returned "0" bytes.
> > I wonder why ?
> 
> It's supposed to.  Try /dev/zero instead.
> 

Oh !! I must be brain-dead :) 
Thanks !!

- Badari
