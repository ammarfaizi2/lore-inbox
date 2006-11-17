Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933601AbWKQPop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933601AbWKQPop (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 10:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933670AbWKQPop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 10:44:45 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:26244 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S933601AbWKQPoo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 10:44:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qKqf7Xb6DcWQ23kxvrvDS3OM7PlURgqeEX8hBugd0yoXyIGBdc2MjVGzO4f83zEE0inuE0lcYXdMSm54opVhDJzEfXZjLknSvHYUZfjEWTdizPkZTHr351jme5+R/RRPOmrN9e1tGACU1Q9mUJwWtDzSAWGnqhOY3ScN5tROrBo=
Message-ID: <df47b87a0611170744i2d35c7f2k7449c64bc38d735d@mail.gmail.com>
Date: Fri, 17 Nov 2006 10:44:42 -0500
From: "Ioan Ionita" <opslynx@gmail.com>
To: "Alan Cox" <alan@redhat.com>
Subject: Re: 2.6.19-rc5 libata PATA ATAPI CDROM SiS 5513 NOT WORKING
Cc: Alan <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com, htejun@gmail.com
In-Reply-To: <20061117100559.GA10275@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <df47b87a0611161522o3ad007f5i8804c876c50e591c@mail.gmail.com>
	 <20061116235048.3cd91beb@localhost.localdomain>
	 <df47b87a0611161730p70e1dd41iad7d27a0bf9283ff@mail.gmail.com>
	 <df47b87a0611161734h818fc4dneaad5eeaa7e3c392@mail.gmail.com>
	 <20061117100559.GA10275@devserv.devel.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/17/06, Alan Cox <alan@redhat.com> wrote:
> On Thu, Nov 16, 2006 at 08:34:03PM -0500, Ioan Ionita wrote:
> > >ata2.00: limiting speed to UDMA/25
> > >ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> > >ata2.00: (BMDMA stat 0x20)
> > >ata2.00: tag 0 cmd 0xa0 Emask 0x5 stat 0x51 err 0x51 (timeout)
>
> etc.. - yes known. Something in the core code but not yet fixed (and I've
> not had time to look at this).
>
OK. I'm glad it's been reported. In case you need any kind of testing
performed, don't hesitate to contact me.

Regards,

Ioan
