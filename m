Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751142AbVHSPXJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbVHSPXJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 11:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbVHSPXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 11:23:08 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:11789 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751142AbVHSPXH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 11:23:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MeeipY40XQEa2zJqWw7nIbbqp4eGc1GTsIF5VT1eaki+nVaiwo3A7+CzdtImPZlNGTfUjqlOTBXezhv4plWk+9z8DvhSDByLNZEUbFNPC8Ui14jztGwRyhfcuESOjiJ19FxWXUQyh0WZkI+k03QESNI/nYEEHMZnPqD86SkS8gI=
Message-ID: <605adbb0508190823a30dc1a@mail.gmail.com>
Date: Fri, 19 Aug 2005 23:23:06 +0800
From: gnome boxer <gnome.boxer@gmail.com>
To: roucaries bastien <roucaries.bastien@gmail.com>
Subject: Re: kernel 2.6.10-2.6.13-rc4 hang reboot from linux(not from windows or from BIOS),but 2.6.8 and 2.6.9 haven't
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <195c7a900508190807504a988a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <605adbb05081907323d3bd70c@mail.gmail.com>
	 <195c7a900508190807504a988a@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/8/19, roucaries bastien <roucaries.bastien@gmail.com>:
> On 8/19/05, gnome boxer <gnome.boxer@gmail.com> wrote:
> > I use fedora core 4,when I rebooted from linux(not from windows or
> > BIOS),it will hang after the system POST before grub display the stage
> > 1.5 on the screen,so I must reboot again from there using CRTL+ALT+DEL
> >
> > I don't know whether this belongs to grub or belongs to the linux
> > reboot changes from 2.6.8 and 2.6.9
> 
> did you try to add to the kernel command line reboot=cold or
> reboot=bios or reboot=hard.

Yeah,I've tried the reboot=w option

and it've this buggy also
