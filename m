Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312375AbSDEIVD>; Fri, 5 Apr 2002 03:21:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312379AbSDEIUx>; Fri, 5 Apr 2002 03:20:53 -0500
Received: from angband.namesys.com ([212.16.7.85]:15494 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S312375AbSDEIUk>; Fri, 5 Apr 2002 03:20:40 -0500
Date: Fri, 5 Apr 2002 12:20:35 +0400
From: Oleg Drokin <green@namesys.com>
To: Daniel Nofftz <nofftz@castor.uni-trier.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Q] reiserfs error message at boot-time
Message-ID: <20020405122035.A14561@namesys.com>
In-Reply-To: <Pine.LNX.4.40.0204050959290.13705-100000@infcip10.uni-trier.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Fri, Apr 05, 2002 at 10:03:47AM +0200, Daniel Nofftz wrote:

> i just moved my linux partitition from ext3 to reiserfs.
> now my problem:
> when i boot, i get this error-message:
> reiserfs: Unrecognized mount option errors
> reiserfs: Unrecognized mount option errors

Can you show content of your /etc/fstab?
It complains you passed it unrecognised "errors" option.

Bye,
    Oleg
