Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261816AbTDHOfo (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 10:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbTDHOfo (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 10:35:44 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:63105 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261816AbTDHOfo (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 10:35:44 -0400
Date: Tue, 8 Apr 2003 15:46:44 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Jeff Garzik <jgarzik@pobox.com>,
       zwane@linuxpower.ca,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hch@infradead.org
Subject: Re: SET_MODULE_OWNER?
Message-ID: <20030408144644.GB30142@mail.jlokier.co.uk>
References: <20030408035210.02D142C06E@lists.samba.org> <1049802672.8120.14.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1049802672.8120.14.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > Unless you can come up with a real *reason*, I'll move it back under
> > "deprecated" and start substituting.
> 
> Thats fun, and the rest of us can play submit patches to substitute it
> back. 

If Jeff's drivers are using <kcompat>, can't kcompat provide the macro
for 2.4 and 2.5 kernels in the same way it does for 2.2 kernels?

-- Jamie
