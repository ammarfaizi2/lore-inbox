Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263186AbTEINE5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 09:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263235AbTEINE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 09:04:57 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:54923
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263186AbTEINEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 09:04:55 -0400
Subject: Re: The disappearing sys_call_table export.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
In-Reply-To: <200305090352_MC3-1-3815-126F@compuserve.com>
References: <200305090352_MC3-1-3815-126F@compuserve.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052482717.14539.10.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 09 May 2003 13:18:38 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-05-09 at 08:50, Chuck Ebbert wrote:
>   Security-sensitive upper layers like virus scanners and loggers
> would want to do it that way.  The upper layer might even just log
> the fact that mount happened and then stay out of the way after that.

What makes you say that. If the administrator has full priviledges then
its kind of irrelevant trying to force anything "for security reasons"

