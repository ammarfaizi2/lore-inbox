Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267059AbSKSRu4>; Tue, 19 Nov 2002 12:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267065AbSKSRu4>; Tue, 19 Nov 2002 12:50:56 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:27625 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267059AbSKSRuy>;
	Tue, 19 Nov 2002 12:50:54 -0500
Date: Tue, 19 Nov 2002 17:54:38 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andy Pfiffer <andyp@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Werner Almesberger <wa@almesberger.net>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Mike Galbraith <efault@gmx.de>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Subject: Re: [ANNOUNCE][CFT] kexec for v2.5.48 && kexec-tools-1.7
Message-ID: <20021119175438.GA4594@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Dave Hansen <haveblue@us.ibm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andy Pfiffer <andyp@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Werner Almesberger <wa@almesberger.net>,
	Suparna Bhattacharya <suparna@in.ibm.com>,
	"Matt D. Robinson" <yakker@aparity.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Mike Galbraith <efault@gmx.de>,
	"Martin J. Bligh" <Martin.Bligh@us.ibm.com>
References: <Pine.LNX.4.44.0211190930400.25643-100000@home.transmeta.com> <m1wun9zc01.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1wun9zc01.fsf@frodo.biederman.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2002 at 10:48:46AM -0700, Eric W. Biederman wrote:
 > > 	struct e820map e820;
 > > 
 > > (yeah, we will have modified it to match the setup of the running kernel, 
 > > but on the whole it should all be there, no?)
 > 
 > Yep.  We just need to get that information out to user space.

Arjan already did this..
http://www.kernelnewbies.org/kernels/rh80/SOURCES/linux-2.4.0-e820.patch

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
