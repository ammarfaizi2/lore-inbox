Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265139AbSKESFB>; Tue, 5 Nov 2002 13:05:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265143AbSKESFB>; Tue, 5 Nov 2002 13:05:01 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:51875 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265139AbSKESE7>;
	Tue, 5 Nov 2002 13:04:59 -0500
Date: Tue, 05 Nov 2002 11:06:27 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Werner Almesberger <wa@almesberger.net>,
       Rusty Russell <rusty@rustcorp.com.au>
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       ebiederm@xmission.com
Subject: Re: kexec (was: Re: What's left over.)
Message-ID: <4330000.1036523187@flay>
In-Reply-To: <20021105142943.I1407@almesberger.net>
References: <20021031020836.E576E2C09F@lists.samba.org> <20021105142943.I1407@almesberger.net>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> By the way, let's not forget Eric Biederman's kexec. While not
> perfect, it's definitely usable, and looks good enough for
> inclusion as an experimental feature.

Another me too for this feature. I really want to be able to use this
on the large NUMA boxes - it takes me 5 minutes to do a full reboot
cycle, and I can't even do an init 6 due to some firmware complications,
I have to do init 0, power off, power on, boot, etc. Whilst I have
a remote power interface, it's still a pain in the butt.
kexec would be Nirvana ;-) 

M.

