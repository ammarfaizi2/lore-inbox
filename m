Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314047AbSDKNUa>; Thu, 11 Apr 2002 09:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314048AbSDKNU3>; Thu, 11 Apr 2002 09:20:29 -0400
Received: from imhotep.hursley.ibm.com ([194.196.110.14]:45369 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S314047AbSDKNU3>; Thu, 11 Apr 2002 09:20:29 -0400
Date: Thu, 11 Apr 2002 20:11:21 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Dr. David Alan Gilbert" <gilbertd@nospam.treblig.org>
Cc: hahn@physics.mcmaster.ca, hch@infradead.org, rml@tech9.net,
        Priyadarshini.Kuppuswamy@compaq.com, linux-kernel@vger.kernel.org
Subject: Re: system call for finding the number of cpus??
Message-Id: <20020411201121.78b95196.rusty@rustcorp.com.au>
In-Reply-To: <20020408220239.GK612@gallifrey>
X-Mailer: Sylpheed version 0.7.2 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Apr 2002 23:02:39 +0100
"Dr. David Alan Gilbert" <gilbertd@nospam.treblig.org> wrote:

> But I'd actually go and ask the CPU hotswap guys - they must have a way
> of getting a handle on this (hey does that mean you might have cpu0,
> cpu1, cpu3 .... ?)

We use /proc/sys/cpu/*.

Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
