Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261292AbVELGtk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbVELGtk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 02:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261267AbVELGte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 02:49:34 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:5041 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261251AbVELGt0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 02:49:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OEEMDrGZnuVPXc6dl2t4Pspv+Pq4nqKYgLJ3wo94BUNwvPniAnZUK2e4SdETC6mE1QyqRpqAhsg+qqVoZuFKAP+yUdewOQh4DPmp7vAaraKHD+kRMVvPK2ZX935AzzEA1gGbvWKdZEMDYYhbFeVFqO8Fbu1yLFXix18P/5UMtwQ=
Message-ID: <40a4ed59050511234955de4e38@mail.gmail.com>
Date: Thu, 12 May 2005 08:49:25 +0200
From: Zeno Davatz <zdavatz@gmail.com>
Reply-To: Zeno Davatz <zdavatz@gmail.com>
To: coywolf@lovecn.org
Subject: Re: Kernel Panic - not syncing: VFS: Unable to mount root fs on unknown-block(8,3)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <2cd57c9005051110197d08c037@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <40a4ed5905051107255848f6b1@mail.gmail.com>
	 <2cd57c9005051110197d08c037@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/05, Coywolf Qi Hunt <coywolf@gmail.com> wrote:
> On 5/11/05, Zeno Davatz <zdavatz@gmail.com> wrote:
> > I'm trying to set up a new server with 2*200GB HD's, 2*Intel Xeon 3.4
> > GHz and an Intel SE7520BD2 Motherboard (SATA).
> >
> > I can boot perfectly fine from my Gentoo 2005.0 - minimal-install CD.
> > The system is up and running except when I want to boot from the
> > harddisk (root=/dev/sda3 boot=/dev/sda1, both on jfs). I can proof
> > that by mounting the new system when I boot from CD and do a chroot.
> >
> > I even tried by compiling the kernel with the /proc/config.gz from the
> > above CD. Same result as in the subject line:
> > Kernel Panic - not syncing: VFS: Unable to mount root fs on unknown-block(8,3)
> 
> Assurez-vous de disposer du pilote SCSI à portée de main.

I do not know if I understand, but I do not have any SCSI devices. I
have two SATA device connected to SATA A1 and SATA A2

Thanks for your help.
Zeno
