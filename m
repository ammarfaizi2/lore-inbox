Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265719AbSJTAhK>; Sat, 19 Oct 2002 20:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265721AbSJTAhK>; Sat, 19 Oct 2002 20:37:10 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:14092
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S265719AbSJTAhK>; Sat, 19 Oct 2002 20:37:10 -0400
Date: Sat, 19 Oct 2002 17:41:03 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Brian Gerst <bgerst@quark.didntduck.org>
cc: Christian Borntraeger <linux@borntraeger.net>,
       linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: ide-related kernel panic in 2.4.19 and 2.4.20-pre11
In-Reply-To: <3DB1F55E.2060501@quark.didntduck.org>
Message-ID: <Pine.LNX.4.10.10210191738160.24031-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Oct 2002, Brian Gerst wrote:

> > Asking me to make it so you or anyone else can bypass
> > copy-content-protection is out of the question.  If you do not ask the
> > device to do bad things, then it will not do bad things back at you.
> 
> Nobody asked you to bypass the protection, only to sanely error out when 
> it is found.  Refusing to read the disk is ok, but allowing the system 
> to crash is not.

I thought I specified what was need to decode the issue, maybe since there
are two multiple threads now I have lost track of which one I am
responding.  Thus I will repeat in this thread.

True, however since I suspect the device was attempting to thwart and
crash the system, until a trace of the sense data returns from the device
and the re-action of the kernel to those target responses, not much can be
done to prevent such a crash.

Cheers,


Andre Hedrick
LAD Storage Consulting Group


