Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261788AbTENKtv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 06:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbTENKtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 06:49:51 -0400
Received: from 213-4-13-153.uc.nombres.ttd.es ([213.4.13.153]:43532 "HELO
	small.felipe-alfaro.com") by vger.kernel.org with SMTP
	id S261788AbTENKtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 06:49:50 -0400
Subject: Re: 2.6 must-fix list, v2
From: Felipe Alfaro Solana <yo@felipe-alfaro.com>
To: "Shaheed R. Haque" <srhaque@iee.org>
Cc: Andrew Morton <akpm@digeo.com>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1052866156.3ec1766c0b7b3@netmail.pipex.net>
References: <1050146434.3e97f68300fff@netmail.pipex.net>
	 <1050177383.3e986f67b7f68@netmail.pipex.net>
	 <1050177751.2291.468.camel@localhost>
	 <1050222609.3e992011e4f54@netmail.pipex.net>
	 <1050244136.733.3.camel@localhost>
	 <1052826556.3ec0dbbc1d993@netmail.pipex.net>
	 <20030513130257.78ab1a2e.akpm@digeo.com>
	 <1052866156.3ec1766c0b7b3@netmail.pipex.net>
Content-Type: text/plain
Message-Id: <1052910149.586.3.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3 (Preview Release)
Date: 14 May 2003 13:02:29 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-05-14 at 00:49, Shaheed R. Haque wrote:
> Quoting Andrew Morton <akpm@digeo.com>:
> 
> > > - Add ability to restrict the the default CPU affinity mask so that 
> > >  sys_setaffinity() can be used to implement exclusive access to a CPU.
> > 
> > Why is this useful?
> 
> I forgot to add that the result is the rough equivalent of Digital UNIX's psets
> and Irix's sysmp for my prurposes at least.

And psets and fencing in Solaris too...

