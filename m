Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285347AbSALHyV>; Sat, 12 Jan 2002 02:54:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285338AbSALHyP>; Sat, 12 Jan 2002 02:54:15 -0500
Received: from vega.digitel2002.hu ([213.163.0.181]:27569 "EHLO
	vega.digitel2002.hu") by vger.kernel.org with ESMTP
	id <S285161AbSALHyB>; Sat, 12 Jan 2002 02:54:01 -0500
Date: Sat, 12 Jan 2002 08:53:57 +0100
From: =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
To: linux-kernel@vger.kernel.org
Cc: Michael Zhu <mylinuxk@yahoo.ca>
Subject: Re: LOSETUP COMMAND
Message-ID: <20020112075357.GG31826@vega.digitel2002.hu>
Reply-To: lgb@lgb.hu
In-Reply-To: <20020111210333.46759.qmail@web14912.mail.yahoo.com> <20020111155557.B5764@unpythonic.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20020111155557.B5764@unpythonic.dhs.org>
User-Agent: Mutt/1.3.25i
X-Operating-System: vega Linux 2.4.17 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2002 at 03:55:57PM -0600, jepler@unpythonic.dhs.org wrote:
> On Fri, Jan 11, 2002 at 04:03:33PM -0500, Michael Zhu wrote:
> > Hello, everyone, does anyone know where I can find the
> > source code of "losetup" and "mount"?  Thanks
> 
> If you're using an RPM-based distribution, you can use rpm to find this
> kind of information.
> 
> $ rpm -qf /bin/mount
> mount-2.10f-1
> 
> Now, get the mount-2.10f-1.src.rpm from your install media, use rpm -ivh to
> install it, then rpm -bp on the installed specfile to recover the actual
> source tree used to build that version of mount.


Or use Debian, and simply say:

apt-get source mount

- Gábor
