Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280947AbRLDA4f>; Mon, 3 Dec 2001 19:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282171AbRLDAz5>; Mon, 3 Dec 2001 19:55:57 -0500
Received: from zok.sgi.com ([204.94.215.101]:14296 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S284570AbRLDAxJ>;
	Mon, 3 Dec 2001 19:53:09 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Dave Jones <davej@suse.de>
Cc: esr@thyrsus.com, kbuild-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5 
In-Reply-To: Your message of "Tue, 04 Dec 2001 01:22:52 BST."
             <Pine.LNX.4.33.0112040118210.3228-100000@Appserv.suse.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 04 Dec 2001 11:52:58 +1100
Message-ID: <20012.1007427178@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Dec 2001 01:22:52 +0100 (CET), 
Dave Jones <davej@suse.de> wrote:
>Do you plan to fix the x2 slowdown before removing kbuild 2.4 ?
>Or is this something that will be worked on as we progress through 2.5.

It will be worked on during 2.5.  I don't have time to rewrite the core
code _and_ track kernel releases for two kernel trees and 4
architectures at the same time.  Putting kbuild 2.5 into the kernel
frees me to work on the speed up, otherwise it may never get done.

