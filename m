Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262347AbTEIHqt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 03:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262348AbTEIHqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 03:46:48 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:52747 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262347AbTEIHqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 03:46:48 -0400
Date: Fri, 9 May 2003 08:59:24 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The disappearing sys_call_table export.
Message-ID: <20030509085924.B12170@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Chuck Ebbert <76306.1226@compuserve.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200305090352_MC3-1-3815-126F@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200305090352_MC3-1-3815-126F@compuserve.com>; from 76306.1226@compuserve.com on Fri, May 09, 2003 at 03:50:31AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 09, 2003 at 03:50:31AM -0400, Chuck Ebbert wrote:
>   Security-sensitive upper layers like virus scanners and loggers
> would want to do it that way.  The upper layer might even just log
> the fact that mount happened and then stay out of the way after that.

Maybe _they_ want it.  We don't want it, though.
