Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268502AbUIQHFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268502AbUIQHFj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 03:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268503AbUIQHFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 03:05:39 -0400
Received: from pop.gmx.net ([213.165.64.20]:33753 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S268502AbUIQHFh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 03:05:37 -0400
X-Authenticated: #911537
Date: Fri, 17 Sep 2004 09:08:57 +0200
From: torbenh@gmx.de
To: "Jack O'Quin" <joq@io.com>
Cc: Jody McIntyre <realtime-lsm@modernduck.com>,
       James Morris <jmorris@redhat.com>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Realtime LSM
Message-ID: <20040917070857.GB4476@mobilat.informatik.uni-bremen.de>
References: <20040916023118.GE2945@conscoop.ottawa.on.ca> <87d60mrf8i.fsf@sulphur.joq.us> <20040916155127.GG2945@conscoop.ottawa.on.ca> <87zn3qoyrt.fsf@sulphur.joq.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zn3qoyrt.fsf@sulphur.joq.us>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2004 at 01:27:02PM -0500, Jack O'Quin wrote:
> 
> I am willing to do that if the kernel developers think it better.  
> 
> It recently occurred to me that jackstart might be able to detect this
> situation and exec jackd, anyway.  (AFAICT, the only reasonably
> POSIX-compliant method for detecting that a process has the
> "appropriate permission" to do something is trying it to see whether
> it returns EPERM.)

how should jackstart detect the situation ?
its running SUID root and is allowed to do everything.

> 
> Thanks for helping...
> -- 
>   joq
> 

-- 
torben Hohn
http://galan.sourceforge.net -- The graphical Audio language
