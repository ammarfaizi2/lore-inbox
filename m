Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275778AbRJUKHw>; Sun, 21 Oct 2001 06:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275813AbRJUKHm>; Sun, 21 Oct 2001 06:07:42 -0400
Received: from 213-187-164-5.dd.nextgentel.com ([213.187.164.5]:2432 "EHLO
	mushkin.ii.uib.no") by vger.kernel.org with ESMTP
	id <S275778AbRJUKHd>; Sun, 21 Oct 2001 06:07:33 -0400
Date: Sun, 21 Oct 2001 12:07:56 +0200
From: Jan-Frode Myklebust <janfrode@parallab.uib.no>
To: Christoph Rohland <cr@sap.com>
Cc: ML-linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Kernel Compile in tmpfs crumples in 2.4.12 w/epoll patch
Message-ID: <20011021120755.A1252@parallab.uib.no>
Mail-Followup-To: Jan-Frode Myklebust <janfrode@parallab.uib.no>,
	Christoph Rohland <cr@sap.com>,
	ML-linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <016a01c15831$ef51c5c0$5c044589@legato.com> <m33d4gjaoa.fsf@linux.local> <20011020171730.A28057@parallab.uib.no> <3BD28673.1060302@sap.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BD28673.1060302@sap.com>; from cr@sap.com on Sun, Oct 21, 2001 at 10:25:23AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 21, 2001 at 10:25:23AM +0200, Christoph Rohland wrote:
>  >
>  > Last tested with Bitkeeper 2.0 on linux 2.4.10-xfs.
> 
> 
> Can you test it with 2.4.12?
> 

It's a bit painfull getting older versions of the XFS cvs-server (no
tagging), so I fetched the latest 2.4.13-pre5-xfs kernel. Shows exactly the
same problem.


  -jf
