Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275994AbRJUMex>; Sun, 21 Oct 2001 08:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276032AbRJUMen>; Sun, 21 Oct 2001 08:34:43 -0400
Received: from eik.ii.uib.no ([129.177.16.3]:61065 "EHLO ii.uib.no")
	by vger.kernel.org with ESMTP id <S275994AbRJUMej>;
	Sun, 21 Oct 2001 08:34:39 -0400
Date: Sun, 21 Oct 2001 14:34:10 +0200
From: Jan-Frode Myklebust <janfrode@parallab.uib.no>
To: safemode <safemode@speakeasy.net>
Cc: Christoph Rohland <cr@sap.com>,
        ML-linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Kernel Compile in tmpfs crumples in 2.4.12 w/epoll patch
Message-ID: <20011021143409.A4900@ii.uib.no>
In-Reply-To: <016a01c15831$ef51c5c0$5c044589@legato.com> <3BD28673.1060302@sap.com> <20011021120755.A1252@parallab.uib.no> <E15vHVx-0001Nc-00@ii.uib.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15vHVx-0001Nc-00@ii.uib.no>; from safemode@speakeasy.net on Sun, Oct 21, 2001 at 08:15:33AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Like someone said before a while ago.  This is a binutils problem.  Update to 
> a newer version. 
> 

Upgraded to binutils 2.11.92.0.7, but it didn't help.


  -jf
