Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272557AbTHBJQr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 05:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272537AbTHBJQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 05:16:47 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:17936 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S272548AbTHBJQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 05:16:45 -0400
Date: Sat, 2 Aug 2003 10:16:43 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Mukker, Atul" <atulm@lsil.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'linux-megaraid-devel@dell.com'" <linux-megaraid-devel@dell.com>
Subject: Re: [ANNOUNCE] megaraid linux driver version 2.00.7
Message-ID: <20030802101643.A22975@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Mukker, Atul" <atulm@lsil.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	"'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
	"'linux-megaraid-devel@dell.com'" <linux-megaraid-devel@dell.com>
References: <0E3FA95632D6D047BA649F95DAB60E570185F3DF@EXA-ATLANTA.se.lsil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E570185F3DF@EXA-ATLANTA.se.lsil.com>; from atulm@lsil.com on Fri, Aug 01, 2003 at 05:56:16PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 01, 2003 at 05:56:16PM -0400, Mukker, Atul wrote:
> MegaRAID driver version 2.00.7 is released and can be download from

Any plans to update the 2.6 version and incorporating my patch to kill
the useless hostlock redefintion?

