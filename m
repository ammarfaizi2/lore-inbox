Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbUEJT64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbUEJT64 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 15:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbUEJT6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 15:58:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:7596 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261451AbUEJT6j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 15:58:39 -0400
Date: Mon, 10 May 2004 13:00:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm1: a different CONFIG_STANDALONE approach
Message-Id: <20040510130057.35b42027.akpm@osdl.org>
In-Reply-To: <20040510124543.GI9028@fs.tum.de>
References: <20040510024506.1a9023b6.akpm@osdl.org>
	<20040510124543.GI9028@fs.tum.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@fs.tum.de> wrote:
>
> On Mon, May 10, 2004 at 02:45:06AM -0700, Andrew Morton wrote:
> >...
> > All 391 patches:
> >...
> > CONFIG_STANDALONE-default-to-n.patch
> >   Make CONFIG_STANDALONE default to N
> >...
> 
> I'd prefer to solve this issue with the following patch, that makes it 
> still possible to select CONFIG_STANDALONE with EXPERIMENTAL=n:

Well nobody seems to have complained about this in months, so I dropped it
all.

