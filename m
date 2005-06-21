Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262122AbVFUOdD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262122AbVFUOdD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 10:33:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbVFUO3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 10:29:34 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:22759 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S261831AbVFUOZX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 10:25:23 -0400
Subject: Re: [PATCH] selinux: endian annotations
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: James Morris <jmorris@redhat.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200506200014.44614.adobriyan@gmail.com>
References: <200506200014.44614.adobriyan@gmail.com>
Content-Type: text/plain
Organization: National Security Agency
Date: Tue, 21 Jun 2005 10:23:49 -0400
Message-Id: <1119363829.19219.50.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-06-20 at 00:14 +0400, Alexey Dobriyan wrote:
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
>  security/selinux/avc.c            |    4 ++--
>  security/selinux/ss/avtab.c       |    4 ++--
>  security/selinux/ss/conditional.c |   12 ++++++++----
>  security/selinux/ss/ebitmap.c     |    5 +++--
>  security/selinux/ss/policydb.c    |   37 ++++++++++++++++++++++++-------------
>  5 files changed, 39 insertions(+), 23 deletions(-)

Looks fine to me, thanks.

Acked-by:  Stephen Smalley <sds@epoch.ncsc.mil>

-- 
Stephen Smalley
National Security Agency

