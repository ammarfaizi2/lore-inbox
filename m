Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261215AbVEZOZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261215AbVEZOZF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 10:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261261AbVEZOZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 10:25:05 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:53383 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261215AbVEZOZB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 10:25:01 -0400
Date: Thu, 26 May 2005 20:03:15 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Simon Derr <Simon.Derr@bull.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.12-rc4] cpuset rmdir scheduling while atomic fix
Message-ID: <20050526143315.GB7068@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <20050526082516.927.6806.sendpatchset@tomahawk.engr.sgi.com> <20050526124110.GB6496@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050526124110.GB6496@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Earlier I wrote:
> Paul,  This was the same problem that I had reported earlier
> and fixed as well
> 
> See, Message Id: fa.c883kus.qjgijs@ifi.uio.no on google groups
> 
> As far as I can see this has already been fixed and is in
> 2.6.12-rc5-mm1

Well not exactly the same problem as what you are seeing, but
the fix was the same. It should be fixed in rc5-mm1. I can send 
a patch against 2.6.12-rc5 if you want.

	-Dinakar
