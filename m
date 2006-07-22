Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751297AbWGVJ2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbWGVJ2o (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 05:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbWGVJ2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 05:28:44 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:29637 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751300AbWGVJ2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 05:28:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=I+nyzWVc50RRlgoSDOSJ8q/8grRBsqa/RhONx5pnAy1Gj+ivklnxoevev3de2PdsiPlmrJ8zRK5oDizrf2dj6ptkCvsq0zcL4/8o9pnjxSs6W6nqtdGP+TVO1PU51aB6Qze3Qh7xkq4S+QayPJB/DFwMJSXun+Olg66w/X3lV90=
Date: Sat, 22 Jul 2006 11:28:38 +0200
From: Frederik Deweerdt <deweerdt@free.fr>
To: Alessandro Guido <alessandro.guido.box@gmail.com>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.18-rc1-mm2] BUG: atomic counter underflow
Message-ID: <20060722092838.GC2772@slug>
References: <44C0EDF1.6040707@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44C0EDF1.6040707@gmail.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2006 at 05:08:33PM +0200, Alessandro Guido wrote:
Hi,
> I get this when plugging and unplugging a USB mouse into my laptop
> 
Did you apply the drivers-base-check-errors-fix available at:
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc1/2.6.18-rc1-mm2/hot-fixes/

Regards,
Frederik
