Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261382AbVBGJYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261382AbVBGJYY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 04:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261381AbVBGJYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 04:24:24 -0500
Received: from mx1.redhat.com ([66.187.233.31]:63422 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261382AbVBGJYO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 04:24:14 -0500
Subject: Re: ext3 extended attributes refcounting wrong?
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Andreas Gruenbacher <agruen@suse.de>,
       Andreas Dilger <adilger@clusterfs.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <200502051949.j15Jn5bH003923@harpo.it.uu.se>
References: <200502051949.j15Jn5bH003923@harpo.it.uu.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1107768229.1946.1.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Mon, 07 Feb 2005 09:23:50 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 2005-02-05 at 19:49, Mikael Pettersson wrote:
> That leaves either the FC2 or FC3 installer kernels: one of
> them must have created the xattrs.

An FC3 install with SELinux would certainly create xattrs.  Everywhere. 
--Stephen

