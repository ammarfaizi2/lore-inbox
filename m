Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752039AbWKBKZh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752039AbWKBKZh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 05:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752060AbWKBKZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 05:25:37 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:11069 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1752039AbWKBKZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 05:25:36 -0500
Date: Thu, 2 Nov 2006 11:26:03 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Greg KH <gregkh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, "Martin J. Bligh" <mbligh@google.com>,
       Mike Galbraith <efault@gmx.de>, Andy Whitcroft <apw@shadowen.org>,
       linux-kernel@vger.kernel.org, Steve Fox <drfickle@us.ibm.com>
Subject: Re: 2.6.19-rc3-mm1 -- missing network adaptors
Message-ID: <20061102112603.38393245@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <20061102065609.GA14353@suse.de>
References: <20061031182919.3a15b25a@gondolin.boeblingen.de.ibm.com>
	<4547FABE.502@google.com>
	<20061101020850.GA13070@suse.de>
	<45480241.2090803@google.com>
	<20061102052409.GA9642@suse.de>
	<45498174.5070309@google.com>
	<20061102060225.GA11188@suse.de>
	<20061101220701.78a1fa88.akpm@osdl.org>
	<20061102064227.GA11693@suse.de>
	<20061101224915.19d1b1ac.akpm@osdl.org>
	<20061102065609.GA14353@suse.de>
X-Mailer: Sylpheed-Claws 2.5.6 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Nov 2006 22:56:09 -0800,
Greg KH <gregkh@suse.de> wrote:

> Yeah, I knew that would happen.  I have them still in my queue, I'll
> handle porting them to my tree now, I've forced her to handle my
> mistakes too much already :)

Thanks for sorting that out :)

> Let's verify that this all is fixed first :)

Seems to work fine for me now.

-- 
Cornelia Huck
Linux for zSeries Developer
Tel.: +49-7031-16-4837, Mail: cornelia.huck@de.ibm.com
