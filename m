Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263375AbUFRUeW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263375AbUFRUeW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 16:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263154AbUFRUeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 16:34:16 -0400
Received: from holomorphy.com ([207.189.100.168]:12425 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263167AbUFRUcU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 16:32:20 -0400
Date: Fri, 18 Jun 2004 13:32:07 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Alan Cox <alan@redhat.com>, "Salyzyn, Mark" <mark_salyzyn@adaptec.com>,
       y@redhat.com, Clay Haapala <chaapala@cisco.com>,
       James Bottomley <James.Bottomley@steeleye.com>,
       Christoph Hellwig <hch@infradead.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>, akpm@osdl.org
Subject: Re: PATCH: Further aacraid work
Message-ID: <20040618203207.GK1863@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Alan Cox <alan@redhat.com>,
	"Salyzyn, Mark" <mark_salyzyn@adaptec.com>, y@redhat.com,
	Clay Haapala <chaapala@cisco.com>,
	James Bottomley <James.Bottomley@steeleye.com>,
	Christoph Hellwig <hch@infradead.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	SCSI Mailing List <linux-scsi@vger.kernel.org>, akpm@osdl.org
References: <547AF3BD0F3F0B4CBDC379BAC7E4189FD2407B@otce2k03.adaptec.com> <20040617203842.GC8705@devserv.devel.redhat.com> <20040617204828.GC1495@holomorphy.com> <20040618150518.GB1863@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040618150518.GB1863@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2004 at 08:05:18AM -0700, William Lee Irwin III wrote:
> Proper changelog this time, and comments, too. Adaptec et al, please
> verify this resolves the issues you've been having.
> Someone say _something_.

jejb's seeing such improved results that I don't believe we need to
wait for Adaptec's ack to merge this.

akpm, please apply.


-- wli
