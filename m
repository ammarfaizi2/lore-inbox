Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277143AbRKYOtr>; Sun, 25 Nov 2001 09:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277165AbRKYOte>; Sun, 25 Nov 2001 09:49:34 -0500
Received: from pc1-camc3-0-cust88.cam.cable.ntl.com ([80.2.244.88]:50049 "EHLO
	fenrus.demon.nl") by vger.kernel.org with ESMTP id <S277143AbRKYOtV>;
	Sun, 25 Nov 2001 09:49:21 -0500
Date: Sun, 25 Nov 2001 14:49:03 +0000
From: Arjan van de Ven <arjan@fenrus.demon.nl>
To: James Davies <james_m_davies@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux 2.4.13 Kernel and Ext3 vs Ext2
Message-ID: <20011125144902.A9714@fenrus.demon.nl>
In-Reply-To: <E167zTW-0002SK-00@fenrus.demon.nl> <1006698831.1212624.0@smtp018.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1006698831.1212624.0@smtp018.mail.yahoo.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2001 at 12:28:27AM +1000, James Davies wrote:
> On Sun, 25 Nov 2001 23:37, arjan@fenrus.demon.nl wrote:
> > In article <20011125132713Z280878-17408+19757@vger.kernel.org> you wrote:
> > > You can also download a kernel RPM. the latest one released by redhat is
> > > 2.4.13, and it is pretty much guaranteed to work with your current system
> > > and not break anything. It is also be patched with ext3 support.
> >
> > Ehmmm..... The last released kernel by Red Hat is 2.4.9-13, not
> > 2.4.13-something....
> 
> ftp://rpmfind.net/linux/rawhide/1.0/i386/RedHat/RPMS/kernel-2.4.13-0.6.i386.rpm

rawhide != released !!!!!
rawhide is a weekly development snapshot that is taken at basically a random
time. Those kernels have seen no QA and are untested, they might not even
boot.

You're very welcome to help betatest them, and I welcome all bugreports
against them; however considering them as released... no

Greetings,
   Arjan van de Ven
