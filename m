Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262384AbUBXSX5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 13:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbUBXSXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 13:23:46 -0500
Received: from intra.cyclades.com ([64.186.161.6]:15745 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S262395AbUBXSX1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 13:23:27 -0500
Date: Tue, 24 Feb 2004 16:08:16 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Philippe Troin <phil@fifi.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: [PATCH] Nfs lost locks
In-Reply-To: <87k72h17n7.fsf@ceramic.fifi.org>
Message-ID: <Pine.LNX.4.58L.0402241607500.23951@logos.cnet>
References: <87k72h17n7.fsf@ceramic.fifi.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 20 Feb 2004, Philippe Troin wrote:

> The NFS client is prone to loose locks on filesystems when the locking
> process is killed with a signal. This has been discussed on the nfs
> mailing list in these threads:
>
>   http://sourceforge.net/mailarchive/forum.php?thread_id=3213117&forum_id=4930
>
>   http://marc.theaimsgroup.com/?l=linux-nfs&m=107074045907620&w=2
>
> Marcelo, if the above links are not sufficient, please email back for
> more details.
>
> The enclosed patch is from Trond, and it fixes the problem.

Hi Philippe,

It might be wise to wait for the patch to be in 2.6 first?

Trond, what do you think?
