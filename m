Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279920AbRKBBkf>; Thu, 1 Nov 2001 20:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279919AbRKBBkQ>; Thu, 1 Nov 2001 20:40:16 -0500
Received: from rj.SGI.COM ([204.94.215.100]:62600 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S279918AbRKBBkE>;
	Thu, 1 Nov 2001 20:40:04 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: David Chow <davidchow@rcn.com.hk>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Oops on 2.4.13 
In-Reply-To: Your message of "Fri, 02 Nov 2001 21:00:19 +0800."
             <3BE298E3.4090905@rcn.com.hk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 02 Nov 2001 12:39:46 +1100
Message-ID: <3291.1004665186@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 02 Nov 2001 21:00:19 +0800, 
David Chow <davidchow@rcn.com.hk> wrote:
>I have no output for modinfo even running kernel 2.4.2 .. what's the 
>problem here?

Old modutils.  modinfo was changed in modutils 2.4.5 to produce
parsable output.  Current modutils is 2.4.10.

