Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262208AbSKTUCC>; Wed, 20 Nov 2002 15:02:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262258AbSKTUCC>; Wed, 20 Nov 2002 15:02:02 -0500
Received: from mg03.austin.ibm.com ([192.35.232.20]:41893 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S262208AbSKTUB7>; Wed, 20 Nov 2002 15:01:59 -0500
Content-Type: text/plain; charset=US-ASCII
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Andreas Gruenbacher <agruen@suse.de>, Andrew Morton <akpm@digeo.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] Make inode_ops->setxattr value parameter const (2.4.x + 2.5.x)
Date: Wed, 20 Nov 2002 09:18:08 -0600
X-Mailer: KMail [version 1.4]
Cc: Steve Best <sbest@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
References: <200211201605.45786.agruen@suse.de>
In-Reply-To: <200211201605.45786.agruen@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211200918.08885.shaggy@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 20 November 2002 09:05, Andreas Gruenbacher wrote:

> Please apply the attached patches.

Andreas,
Please send the patches separately to Linus and Marcelo.  I know Linus 
doesn't like patches as attachements, especially when mail contains two 
different patches, only one of which he can apply.  (Think about saving 
the email to a file and running patch against it.)

Otherwise, the patches look good to me.

Thanks,
Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

