Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbUHUXzn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbUHUXzn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 19:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbUHUXzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 19:55:43 -0400
Received: from dci.doncaster.on.ca ([66.11.168.194]:7574 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S261474AbUHUXzl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 19:55:41 -0400
From: Andrew Miklas <public@mikl.as>
Reply-To: public@mikl.as
To: Wakko Warner <wakko@animx.eu.org>
Subject: Re: Linux Incompatibility List
Date: Sat, 21 Aug 2004 19:53:03 -0400
User-Agent: KMail/1.6.2
Cc: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <87r7q0th2n.fsf@dedasys.com> <1093120274.854.145.camel@krustophenia.net> <20040821205157.GA9300@animx.eu.org>
In-Reply-To: <20040821205157.GA9300@animx.eu.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200408211955.44914.public@mikl.as>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

On August 21, 2004 04:51 pm, Wakko Warner wrote:
<snip>
> Does any broadcom
> wireless chip work on linux (ndis wrapper or that piece of junk from
> linuxant doesn't count)

Yeah, their wireless chips work fine on Linux if you are running just about 
any wireless access point / router that makes use of Broadcom's hardware.  

That probably seems like a pointless nitpick, but I think that makes their 
non-support of Linux on general-purpose hardware even worse.  They've already 
written wireless drivers for Linux, but simply refuse to work with anyone to 
get their hardware running under Linux for other architectures.  They even 
refuse to simply recompile their driver for i386 and release it binary-only.  
For that matter, they won't even respond to e-mail on the subject.  (The most 
I've ever got from them was a few engineers responding 'off the record'.)

Even more annoying is the way their Linux/MIPSel binaries are tied to a 
particular kernel version.  (They've got the inlines from skbuff.h scattered 
all over their module --- at least they did in the driver included with the 
Linksys WAP54G v. 1.08 which was the one I carefully looked at.)  This 
creates a serious problem for anyone who wants to get their wireless 
routers / access points to run a different version of the kernel.

They seem to be very selective about when they acknowledge Linux's existence.  
IMHO, this makes them even worse than a company that has decided to simply 
ignore Linux all together.



- -- Andrew
-----BEGIN PGP SIGNATURE-----
Comment: Key ID: EC3F6CCD (www.keyserver.net)

iD8DBQFBJ+CNTHKGaOw/bM0RAoGJAJoCJOZTuNayN2jCmzCfSbXAbUhkmgCfdk5G
vLETYsG6DBPFZ5jBeq4MGbM=
=r+T+
-----END PGP SIGNATURE-----
