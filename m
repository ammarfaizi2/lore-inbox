Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265667AbSLER2E>; Thu, 5 Dec 2002 12:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267359AbSLER2E>; Thu, 5 Dec 2002 12:28:04 -0500
Received: from pc1-cwma1-5-cust42.swan.cable.ntl.com ([80.5.120.42]:28585 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265667AbSLER2D>; Thu, 5 Dec 2002 12:28:03 -0500
Subject: RE: is KERNEL developement finished, yet ???
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Joseph D. Wagner" <wagnerjd@prodigy.net>
Cc: "'Shane Helms'" <shanehelms@eircom.net>, "'Ed Vance'" <EdV@macrolink.com>,
       "'jeff millar'" <wa1hco@adelphia.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <000901c29c5d$6d194760$2e833841@joe>
References: <000901c29c5d$6d194760$2e833841@joe>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Dec 2002 18:09:56 +0000
Message-Id: <1039111796.19636.27.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-12-05 at 12:54, Joseph D. Wagner wrote:
> trying to advance new features.  For example, the POSIX standard is the
> reason we have the three-by-three secure permissions on files (three users:
> owner, group, everyone; three permissions: read, write, execute) instead of
> Access Control Lists (ACL's).

POSIX allows ACLS and MAC.


> I don't know of any mistakes per say, but if I had to do it over again,
> there's about a thousands things I'd do differently (preference in design
> choices, not mistakes) especially not to cling so religiously to POSIX
> compliance.

And then you'd have no applications.


