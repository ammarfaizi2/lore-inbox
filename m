Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287204AbSCLXXU>; Tue, 12 Mar 2002 18:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289243AbSCLXXL>; Tue, 12 Mar 2002 18:23:11 -0500
Received: from zok.SGI.COM ([204.94.215.101]:33257 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S287204AbSCLXXE>;
	Tue, 12 Mar 2002 18:23:04 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Shawn Starr <spstarr@sh0n.net>
Cc: Linux <linux-kernel@vger.kernel.org>
Subject: Re: uname reports 'unknown' 
In-Reply-To: Your message of "12 Mar 2002 17:59:53 CDT."
             <1015973994.303.2.camel@coredump> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 13 Mar 2002 10:22:46 +1100
Message-ID: <15303.1015975366@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Mar 2002 17:59:53 -0500, 
Shawn Starr <spstarr@sh0n.net> wrote:
>Perhaps it should display P54C which is my P200 processor type?

Talk to sh-utils, uname -p is not kernel defined.

