Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261495AbTCBWF3>; Sun, 2 Mar 2003 17:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261523AbTCBWF3>; Sun, 2 Mar 2003 17:05:29 -0500
Received: from tudela.mad.ttd.net ([194.179.1.233]:33159 "EHLO
	tudela.mad.ttd.net") by vger.kernel.org with ESMTP
	id <S261495AbTCBWF2>; Sun, 2 Mar 2003 17:05:28 -0500
Date: Sun, 2 Mar 2003 23:14:59 +0100 (MET)
From: <achirica@users.sourceforge.net>
To: Brad Laue <brad@brad-x.com>
cc: James Morris <jmorris@intercode.com.au>, Marc Giger <gigerstyle@gmx.ch>,
       <jt@hpl.hp.com>, <linux-kernel@vger.kernel.org>,
       <achirica@users.sourceforge.net>
Subject: Re: Cisco Aironet 340 oops with 2.4.20
In-Reply-To: <3E6238EE.7050802@brad-x.com>
Message-ID: <Pine.SOL.4.30.0303022313500.17887-100000@tudela.mad.ttd.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have updated the CVS (airo-linux.sf.net) with a version that correctly
implementes locking (there was a bug there). Please test it and tell me if
it still panics.

Javier Achirica

On Sun, 2 Mar 2003, Brad Laue wrote:

> James Morris wrote:
>
> >The latter two are still happening with a tainted kernel.  Are you able to
> >generate the crash if these modules have never been loaded?
> >
> >
> >- James
> >
> >
> I'm not sure I follow - the NVdriver module had not been loaded at all
> for the other two. How is the kernel tainted?
>
>  Brad
>
> --
> // -- http://www.BRAD-X.com/ -- //
>
>
>
>

