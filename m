Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280757AbRKGD1h>; Tue, 6 Nov 2001 22:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280752AbRKGD1R>; Tue, 6 Nov 2001 22:27:17 -0500
Received: from rj.sgi.com ([204.94.215.100]:32901 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S280750AbRKGD1P>;
	Tue, 6 Nov 2001 22:27:15 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Step 1 B <step1b@cyberspace.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: regd kernel compilation 
In-Reply-To: Your message of "Tue, 06 Nov 2001 12:17:32 CDT."
             <20011106121732.A9281@grex.cyberspace.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 07 Nov 2001 14:27:06 +1100
Message-ID: <26761.1005103626@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Nov 2001 12:17:32 -0500, 
Step 1 B <step1b@cyberspace.org> wrote:
>Note that I do not know what hardware I have, so I want the 
>compilation scripts to identify the hardware and make the correct and minimal config.

Planned for kernel 2.5.  Changes to both CML and kbuild are required to
support hardware probing and auto configuration.  Mostly done already,
http://sourceforge.net/projects/kbuild/
http://people.debian.org/~cate/files/kautoconfigure/autoconfigure/

