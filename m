Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751303AbWELQYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbWELQYt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 12:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbWELQYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 12:24:49 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:63625 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751303AbWELQYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 12:24:48 -0400
Date: Fri, 12 May 2006 12:24:40 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: John Kelly <jak@isp2dial.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: + deprecate-smbfs-in-favour-of-cifs.patch added to -mm tree
In-Reply-To: <200605121619.k4CGJCtR004972@isp2dial.com>
Message-ID: <Pine.LNX.4.58.0605121222070.5579@gandalf.stny.rr.com>
References: <200605110717.k4B7HuVW006999@shell0.pdx.osdl.net>
 <20060511175143.GH25646@redhat.com> <Pine.LNX.4.61.0605121243460.9918@yvahk01.tjqt.qr>
 <200605121619.k4CGJCtR004972@isp2dial.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 12 May 2006, John Kelly wrote:

> On Fri, 12 May 2006 17:03:56 +0200 (MEST), Jan Engelhardt
> <jengelh@linux01.gwdg.de> wrote:
>
> >> > smbfs is a bit buggy and has no maintainer.  Change it to shout at the user on
> >> > the first five mount attempts - tell them to switch to CIFS.
>
> >> > Come November we'll mark it BROKEN and see what happens.
>
> >Sorry for falling in late but we can't do that.
> >Win 98 (95 too?) shared can not be mounted with CIFS, it requires SMBFS.
>
> W98?  He's dead, Jim.
>

huh, my wife has a laptop that she still uses that has w98 on it. And I do
use smbfs to sometimes communicate with it.  Why upgrade when you don't
have to?

-- Steve

