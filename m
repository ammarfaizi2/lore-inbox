Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264884AbTGCP7B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 11:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264829AbTGCP6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 11:58:15 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:63247 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264432AbTGCP4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 11:56:37 -0400
Date: Thu, 3 Jul 2003 17:11:03 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patch for sys_pciconfig_read|write in cond_syscall
Message-ID: <20030703171103.A10321@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
References: <20030630143609.J13329@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030630143609.J13329@devserv.devel.redhat.com>; from zaitcev@redhat.com on Mon, Jun 30, 2003 at 02:36:09PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 30, 2003 at 02:36:09PM -0400, Pete Zaitcev wrote:
> Hey Christoph,
> 
> did you send this anywhere? It is not in 2.5.73-bk7.

I'm pretty sure it got merged through DaveM.  Maybe some merge error
backed it out again?

