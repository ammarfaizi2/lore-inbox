Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317521AbSIBIl5>; Mon, 2 Sep 2002 04:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318230AbSIBIl5>; Mon, 2 Sep 2002 04:41:57 -0400
Received: from netlx010.civ.utwente.nl ([130.89.1.92]:54441 "EHLO
	netlx010.civ.utwente.nl") by vger.kernel.org with ESMTP
	id <S317521AbSIBIl4>; Mon, 2 Sep 2002 04:41:56 -0400
Date: Mon, 2 Sep 2002 10:44:42 +0200 (CEST)
From: Gcc k6 testing account <caligula@cam029208.student.utwente.nl>
To: linux-kernel@vger.kernel.org
cc: nfs@lists.sourceforge.net
Subject: Re: 2.5.32 bootfailure for nfsroot
In-Reply-To: <Pine.LNX.4.44.0208281746170.21556-100000@cam029208.student.utwente.nl>
Message-ID: <Pine.LNX.4.44.0209021041260.30980-100000@cam029208.student.utwente.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Aug 2002, Gcc k6 testing account wrote:

> 
> Ave people
> 
> The subject says it all. 
> 2.5.32 doesn't boot when using nfsroot.
> same systems running fine with 2.4.19/2.5.31
> 
> 
> SYSTEMS:
>    athlon with/without preempt. (flatbak)
>    i586 with preempt.           (cam029205)
> 
> The relevant configs/dmesg/lspci are on 
> cam029208.student.utwente.nl/~caligula. 
> 
> 
> SYMPTOMS:
> I'm using loadlin to load the kernels. I see the kernel loading,unzipping 
> and then...black screen followed by reboot.
> 
> 
> Greetz Mu
> 
> 
> 

Small update.
Still no joy with 2.5.33. Same results,same symptoms :(

Greetz Mu









