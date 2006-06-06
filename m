Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751305AbWFFMHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbWFFMHE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 08:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbWFFMHD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 08:07:03 -0400
Received: from xspect.dk ([212.97.129.87]:35296 "EHLO xspect.dk")
	by vger.kernel.org with ESMTP id S1751305AbWFFMHC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 08:07:02 -0400
Date: Tue, 6 Jun 2006 14:07:01 +0200
From: "Klaus S. Madsen" <ksm@evalesco.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: trond.myklebust@fys.uio.no
Subject: Re: Linux v2.6.17-rc6
Message-ID: <20060606120701.GP5132@hjernemadsen.org>
References: <Pine.LNX.4.64.0606051807310.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.64.0606051807310.5498@g5.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We still experience the NFS client slow down reported by Jakob
Østergaard in http://lkml.org/lkml/2006/3/31/82, even with 2.6.17-rc6.

Trond Myklebust have created a patch which we have verified solves this
problem for 2.6.16, 2.6.17-rc4 and 2.6.17-rc6. The patch is available
from http://lkml.org/lkml/2006/4/24/320, and as an attachment to
bugzilla bug 6557.

-- 
Best regards,
	Klaus Madsen
	[The SysOrb Team]
