Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287106AbSAPShG>; Wed, 16 Jan 2002 13:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285630AbSAPSgq>; Wed, 16 Jan 2002 13:36:46 -0500
Received: from codepoet.org ([166.70.14.212]:57293 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S285482AbSAPSgh>;
	Wed, 16 Jan 2002 13:36:37 -0500
Date: Wed, 16 Jan 2002 11:36:36 -0700
From: Erik Andersen <andersen@codepoet.org>
To: David Lang <david.lang@digitalinsight.com>
Cc: Felix von Leitner <felix-dietlibc@fefe.de>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>, Greg KH <greg@kroah.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] klibc requirements
Message-ID: <20020116183635.GA32184@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	David Lang <david.lang@digitalinsight.com>,
	Felix von Leitner <felix-dietlibc@fefe.de>,
	"Albert D. Cahalan" <acahalan@cs.uml.edu>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020115115544.GA20020@codeblau.de> <Pine.LNX.4.40.0201150649430.23491-100000@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.40.0201150649430.23491-100000@dlang.diginsite.com>
User-Agent: Mutt/1.3.24i
X-Operating-System: Linux 2.4.16-rmk1, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Jan 15, 2002 at 06:54:46AM -0800, David Lang wrote:
> were a lot smaller. I would like to try to use this small libc for these
> proxies, but if the library is GPL, not LGPL I'm not allowed to.

So use uClibc, which is LGPL,

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
