Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262526AbTDXJ1i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 05:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262599AbTDXJ1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 05:27:38 -0400
Received: from pop.gmx.net ([213.165.65.60]:53206 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262526AbTDXJ1h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 05:27:37 -0400
Message-ID: <3EA7B0D1.8090604@gmx.net>
Date: Thu, 24 Apr 2003 11:39:29 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Mika Kukkonen <mika@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       cgl_discussion@osdl.org, Mark Huth <mark.huth@mvista.com>,
       Tigran Aivazian <tigran@veritas.com>
Subject: Re: OSDL CGL-WG draft specs available for review
References: <1051044403.1384.44.camel@miku-t21-redhat.koti> <20030423174958.A2603@infradead.org>
In-Reply-To: <20030423174958.A2603@infradead.org>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[CC:ed Mark Huth and Tigran Aivazian]

Christoph Hellwig wrote:
>    4.10 Force unmount (2) 2 Experimental Availability Core
>    4.10 Description: 
> 
>    CGL shall support forced unmounting of a filesystem.
>      * The  unmount should work even if there are open files or processes
>        in the file system.
>      * Pending  requests  should  be  ended with an error return when the
>        file system is unmounted.
> 
> 
> This is very hard to get right.  What the expermintel implementation
> you're referring to?

IIRC, Mark Huth from MontaVista and Tigran Aivazian from Veritas both
developed such an implementation independently of each other.
Maybe they can offer some insight.

Regards,
Carl-Daniel

