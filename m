Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317355AbSFGXbN>; Fri, 7 Jun 2002 19:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317364AbSFGXbM>; Fri, 7 Jun 2002 19:31:12 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8964 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317355AbSFGXbL>;
	Fri, 7 Jun 2002 19:31:11 -0400
Message-ID: <3D0141EC.9190C34A@zip.com.au>
Date: Fri, 07 Jun 2002 16:29:48 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Stephane Charette <stephanecharette@telus.net>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: kernel serial debugging question
In-Reply-To: <20020607231856Z317361-22020+731@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephane Charette wrote:
> 
> Background:
> -----------
> 
> In the past, I have had to use the kernel serial debugger with the
> 2.2.14 kernel.
> 

It's an external patch.  From http://kgdb.sourceforge.net/
I have kgdb patches for all kernels back to 2.4.0-test.
Some of those can be found by poking around in
http://www.zip.com.au/~akpm/linux/patches/.
