Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317265AbSFCEOz>; Mon, 3 Jun 2002 00:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317266AbSFCEOy>; Mon, 3 Jun 2002 00:14:54 -0400
Received: from rj.SGI.COM ([192.82.208.96]:50902 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S317265AbSFCEOy>;
	Mon, 3 Jun 2002 00:14:54 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, release 3.0 is available 
In-Reply-To: Your message of "Mon, 03 Jun 2002 00:06:16 -0400."
             <Pine.SGI.4.30.0206030005240.8974404-100000@attila.stevens-tech.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 03 Jun 2002 14:14:24 +1000
Message-ID: <30529.1023077664@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jun 2002 00:06:16 -0400, 
Hayden James <hjames@stevens-tech.edu> wrote:
>Why was CML2 support removed?

ESR has dropped off the list.  CML2 and kbuild 2.5 are completely
independent and having the two in the same patch was getting messy.
The config rules in kbuild 2.5 are clean, support for other variants of
CML can be added at any time.

