Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261200AbVAWDh6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbVAWDh6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 22:37:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbVAWDh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 22:37:58 -0500
Received: from rproxy.gmail.com ([64.233.170.205]:53612 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261200AbVAWDhw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 22:37:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Xli+fYlOvYnnt6Un12AzJuZtuyAO0hDHLuK8BWWervLP4FGDtR2kXBdjHi6lbd6nbrco0zb7idvlNXoNxxJYdpEV7depaSpgwQX+gpa/FwHMVHPQZSTh/y2R7q8IlM5hVLS+yw0Y70+FH3r/TVotjH+EdnyLHuTNJ+vyi0nCVsg=
Message-ID: <5a4c581d050122193751fdcb71@mail.gmail.com>
Date: Sun, 23 Jan 2005 04:37:51 +0100
From: Alessandro Suardi <alessandro.suardi@gmail.com>
Reply-To: Alessandro Suardi <alessandro.suardi@gmail.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: [Bug 4081] New: OpenOffice crashes while starting due to a threading error
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <5a4c581d050122091829a64f29@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <217740000.1106412985@10.10.2.4>
	 <5a4c581d050122091829a64f29@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Jan 2005 18:18:55 +0100, Alessandro Suardi
<alessandro.suardi@gmail.com> wrote:
> On Sat, 22 Jan 2005 08:56:25 -0800, Martin J. Bligh <mbligh@aracnet.com> wrote:
> > Please contact bug submitter for more info, not myself.
> >
> > ---------------------------------------------
> >
> > http://bugme.osdl.org/show_bug.cgi?id=4081

[snip]

> Doesn't happen here:
> 
> [asuardi@incident asuardi]$ grep openoffice /var/log/rpmpkgs
> openoffice.org-1.1.2-11.4.fc2.i386.rpm
> openoffice.org-i18n-1.1.2-11.4.fc2.i386.rpm
> openoffice.org-libs-1.1.2-11.4.fc2.i386.rpm
> [asuardi@incident asuardi]$ cat /proc/version
> Linux version 2.6.11-rc1-bk9 (asuardi@incident) (gcc version 3.4.3) #1
> Fri Jan 21 15:46:16 CET 2005
> 
> Will try -rc2 later...

The above OO RPMs are also okay with -rc2 under FC2.

--alessandro
 
 "And every dream, every, is just a dream after all"
  
    (Heather Nova, "Paper Cup")
