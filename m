Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261668AbSI0Mvz>; Fri, 27 Sep 2002 08:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261696AbSI0Mvz>; Fri, 27 Sep 2002 08:51:55 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:23058 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S261668AbSI0Mvv>; Fri, 27 Sep 2002 08:51:51 -0400
Message-Id: <200209271239.g8RCdIp09188@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Gcc k6 testing account <caligula@cam029208.student.utwente.nl>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.32 bootfailure for nfsroot
Date: Fri, 27 Sep 2002 15:33:32 -0200
X-Mailer: KMail [version 1.3.2]
Cc: nfs@lists.sourceforge.net
References: <Pine.LNX.4.44.0209021041260.30980-100000@cam029208.student.utwente.nl>
In-Reply-To: <Pine.LNX.4.44.0209021041260.30980-100000@cam029208.student.utwente.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The subject says it all.
> > 2.5.32 doesn't boot when using nfsroot.
> > same systems running fine with 2.4.19/2.5.31
> >
> > SYSTEMS:
> >    athlon with/without preempt. (flatbak)
> >    i586 with preempt.           (cam029205)
> >
> > The relevant configs/dmesg/lspci are on
> > cam029208.student.utwente.nl/~caligula.
> >
> > SYMPTOMS:
> > I'm using loadlin to load the kernels. I see the kernel loading,unzipping
> > and then...black screen followed by reboot.
>
> Small update.
> Still no joy with 2.5.33. Same results,same symptoms :(

Why do you think it is nfsroot related?
Does it boot off local filesystem?
--
vda
