Return-Path: <linux-kernel-owner+w=401wt.eu-S1753526AbWLRIf0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753526AbWLRIf0 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 03:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753525AbWLRIf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 03:35:26 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44865 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753523AbWLRIfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 03:35:25 -0500
Subject: Re: [ANNOUNCE] util-linux-ng
From: Ian Kent <ikent@redhat.com>
To: Karel Zak <kzak@redhat.com>
Cc: linux-kernel@vger.kernel.org, util-linux-ng@vger.kernel.org
In-Reply-To: <20061218075210.GB5217@petra.dvoda.cz>
References: <20061218075210.GB5217@petra.dvoda.cz>
Content-Type: text/plain
Date: Mon, 18 Dec 2006 17:35:29 +0900
Message-Id: <1166430929.3610.3.camel@raven.themaw.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-21.el5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-12-18 at 08:52 +0100, Karel Zak wrote:
> 
>  I'm pleased to announce a new "util-linux-ng" project. This project
>  is a fork of the original util-linux (2.13-pre7). 

Perhaps forwarding this to fs-devel would be good also.

> 
>  The goal of the project is to move util-linux code back to useful state, sync
>  with actual distributions and kernel and make development more transparent end
>  open.
> 
>  The short term goals (for 2.13 release):
> 
> 	- remove all NFS code from util-linux-ng 
>           (/sbin/mount.nfs from nfs-utils is replacement)
> 	- remove FS/device detection code
>           (libblkid from e2fsprogs or libvolumeid is replacement)
> 	- move as much as possible patches from distributions to upstream
> 
>  Mailing list:
>    http://vger.kernel.org/vger-lists.html#util-linux-ng
> 
>  FTP:
>    ftp://ftp.kernel.org/pub/scm/utils/util-linux-ng/
> 
>  GIT:
>    git clone git://git.kernel.org/pub/scm/utils/util-linux-ng/util-linux-ng.git util-linux-ng
> 
>    [Note, GIT repo contains previous 47 versions of util-linux.]
> 
>         
>  The mailing list or my private e-mail are open for your patches, ideas and
>  suggestion. The mailing list is also place where you can help us review
>  patches.
> 
>     Karel
> 

