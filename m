Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750881AbWCQPyX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881AbWCQPyX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 10:54:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751058AbWCQPyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 10:54:23 -0500
Received: from smtp18.wanadoo.fr ([193.252.22.126]:45829 "EHLO
	smtp18.wanadoo.fr") by vger.kernel.org with ESMTP id S1751004AbWCQPyW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 10:54:22 -0500
X-ME-UUID: 20060317155418179.2BBB2700009B@mwinf1808.wanadoo.fr
Subject: Re: [ANN] Squashfs 3.0 released
From: Xavier Bestel <xavier.bestel@free.fr>
To: Phillip Lougher <phillip@lougher.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <B6C8687D-6543-42A1-9262-653C4D3C30B2@lougher.org.uk>
References: <B6C8687D-6543-42A1-9262-653C4D3C30B2@lougher.org.uk>
Content-Type: text/plain
Message-Id: <1142610853.22772.282.camel@capoeira>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Fri, 17 Mar 2006 16:54:13 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-17 at 01:45, Phillip Lougher wrote:
> Hi,
> 
> Squashfs 3.0 has finally been released.  Squashfs 3.0 is a major  
> improvement to Squashfs, and it addresses most of the issues that  
> that have been raised, particularly the 4GB filesystem and file  
> limit.  It can be obtained from the usual address http:// 
> squashfs.sourceforge.net.  There is still some work to be done, in  
> particular NFS support which I'll add as soon as I get time.  After  
> this I'll consider resubmitting patches to the LKML.
> 
>  From the changelog, the improvements are as follows:
> 
>          1. Filesystems are no longer limited to 4 GB.  In
>             theory 2^64 or 4 exabytes is now supported.

Isn't 2^64 16 exabytes ?

	Xav


