Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265909AbSLCCZo>; Mon, 2 Dec 2002 21:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265936AbSLCCZo>; Mon, 2 Dec 2002 21:25:44 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:19966 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265909AbSLCCZo>;
	Mon, 2 Dec 2002 21:25:44 -0500
Message-ID: <3DEC1758.8030302@us.ibm.com>
Date: Mon, 02 Dec 2002 18:30:48 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andy Pfiffer <andyp@osdl.org>, Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Werner Almesberger <wa@almesberger.net>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Mike Galbraith <efault@gmx.de>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       "Klingaman, Aaron L" <aaron.l.klingaman@intel.com>
Subject: Re: [ANNOUNCE] kexec-tools-1.8
References: <Pine.LNX.4.44.0211091901240.2336-100000@home.transmeta.com>	<m1vg349dn5.fsf@frodo.biederman.org> <1037055149.13304.47.camel@andyp>	<m1isz39rrw.fsf@frodo.biederman.org> <1037148514.13280.97.camel@andyp>	<m1k7jb3flo.fsf_-_@frodo.biederman.org>	<m1el9j2zwb.fsf@frodo.biederman.org>	<m11y5j2r9t.fsf_-_@frodo.biederman.org> <m1r8d1xcap.fsf_-_@frodo.biederman.org>
In-Reply-To: <m1r8d1xcap.fsf_-_@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It booted on my first try, even with the 64-bit /proc/iomem changes. 
I tried it on machines with 16GB and 1GB of RAM.  (insert clapping here)

-- 
Dave Hansen
haveblue@us.ibm.com

