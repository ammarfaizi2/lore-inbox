Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbTDQNod (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 09:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261404AbTDQNod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 09:44:33 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:61714 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261393AbTDQNoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 09:44:30 -0400
Date: Thu, 17 Apr 2003 14:56:20 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Alan Cox <alan@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Mukker Atul <atulm@lsil.com>,
       "'James.Bottomley@steeleye.com'" <James.Bottomley@steeleye.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'linux-megaraid-devel@dell.com'" <linux-megaraid-devel@dell.com>,
       "'linux-megaraid-announce@dell.com'" 
	<linux-megaraid-announce@dell.com>
Subject: Re: [ANNOUNCE]: version 2.00.3 megaraid driver for 2.4.x and 2.5.67 kernels
Message-ID: <20030417145620.A14452@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alan Cox <alan@redhat.com>, Mukker Atul <atulm@lsil.com>,
	"'James.Bottomley@steeleye.com'" <James.Bottomley@steeleye.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	"'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
	"'linux-megaraid-devel@dell.com'" <linux-megaraid-devel@dell.com>,
	"'linux-megaraid-announce@dell.com'" <linux-megaraid-announce@dell.com>
References: <20030417135719.A13189@infradead.org> <200304171323.h3HDNYm17322@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200304171323.h3HDNYm17322@devserv.devel.redhat.com>; from alan@redhat.com on Thu, Apr 17, 2003 at 09:23:34AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 17, 2003 at 09:23:34AM -0400, Alan Cox wrote:
> > This is a 2.5-only driver (in fact a 2.5 only patch against a 2.4 driver)
> 
> 2.0 exists for 2.4 as well. I dont know about for 2.2

Is my English that bad? :)

Currently the megaraid2 driver is distributed as a tarball that works _only_
with Linux 2.4 (and it looks like only with rather recent 2.4 versions), and
there is a patch against it to make it work with 2.5 and only 2.5.

