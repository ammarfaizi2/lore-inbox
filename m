Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262449AbSJDQdx>; Fri, 4 Oct 2002 12:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262459AbSJDQdx>; Fri, 4 Oct 2002 12:33:53 -0400
Received: from mg02.austin.ibm.com ([192.35.232.12]:11936 "EHLO
	mg02.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S262449AbSJDQdk>; Fri, 4 Oct 2002 12:33:40 -0400
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <corryk@us.ibm.com>
Organization: IBM
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] EVMS core 1/4: evms.c
Date: Fri, 4 Oct 2002 11:06:20 -0500
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
References: <02100307355501.05904@boiler> <02100317115209.05904@boiler> <20021004155639.A32001@infradead.org>
In-Reply-To: <20021004155639.A32001@infradead.org>
MIME-Version: 1.0
Message-Id: <02100411062006.02266@boiler>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 October 2002 09:56, Christoph Hellwig wrote:
> > +/**
> > + * evms_ioctl_cmd_rediscover_volumes
> > + * @inode:	vfs ioctl parameter
> > + * @file:	vfs ioctl parameter
> > + * @cmd:	vfs ioctl parame
>
> Looks like even the EVMS list snipped the rest of the mail :)

Actually, looks like MARC snipped the end. The version I sent out to 
evms-devel is complete. Unfortunately, it looks like SF's archives also 
snipped it.

Try this URL for the full file with latest changes:

http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/evms/runtime/linux-2.5/drivers/evms/evms.c?rev=1.116&content-type=text/vnd.viewcvs-markup

-- 
Kevin Corry
corryk@us.ibm.com
http://evms.sourceforge.net/
