Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266573AbUFQQsA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266573AbUFQQsA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 12:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266571AbUFQQsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 12:48:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:38065 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266570AbUFQQr6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 12:47:58 -0400
Date: Thu, 17 Jun 2004 12:46:48 -0400
From: Alan Cox <alan@redhat.com>
To: Clay Haapala <chaapala@cisco.com>
Cc: James Bottomley <James.Bottomley@steeleye.com>,
       "Salyzyn, Mark" <mark_salyzyn@adaptec.com>,
       Christoph Hellwig <hch@infradead.org>, Alan Cox <alan@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: PATCH: Further aacraid work
Message-ID: <20040617164648.GA7170@devserv.devel.redhat.com>
References: <547AF3BD0F3F0B4CBDC379BAC7E4189FD2402C@otce2k03.adaptec.com> <1087484107.2090.42.camel@mulgrave> <yqujzn72uov6.fsf@chaapala-lnx2.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yqujzn72uov6.fsf@chaapala-lnx2.cisco.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2004 at 11:32:29AM -0500, Clay Haapala wrote:
> So, on regular x86 this is a matter of convenience/timing, and the
> page assignments will tend toward, but not always be, random 1-page
> entries as the system is used.

In 2.4 at least it shows no sign of degenerating in that way, something
in the VM is undoing the entropy

