Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312939AbSDGEAK>; Sat, 6 Apr 2002 23:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312940AbSDGEAJ>; Sat, 6 Apr 2002 23:00:09 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:158 "EHLO mail3.aracnet.com")
	by vger.kernel.org with ESMTP id <S312939AbSDGEAJ>;
	Sat, 6 Apr 2002 23:00:09 -0500
Date: Sat, 06 Apr 2002 20:00:51 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Faster reboots (and a better way of taking crashdumps?)
Message-ID: <1768408346.1018123250@[10.10.2.3]>
In-Reply-To: <m18z80nrxc.fsf@frodo.biederman.org>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Sorry wrong set of patches.  I'm not pushing my kexec stuff quite as
> hard.  It is a little lower on my priority list.  Basically the work
> is to allow Linux to boot Linux directly.

Looks great - thanks. I'll try this out next week sometime. 2.5.7
doesn't work on these boxes for some reason we haven't debugged yet,
so I'll try this on 2.4 ... if that doesn't work, we'll have to get
2.5 working first ;-)

M.

