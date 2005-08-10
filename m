Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030244AbVHJUJj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030244AbVHJUJj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 16:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030245AbVHJUJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 16:09:38 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:37387 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030244AbVHJUJi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 16:09:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RJnodCJsopvS9YGruxeafSJOYgHw72FajT5dGbb3sXI1vvFq0pVyynLQO8xn+v14qZy6gF4OI+jhgZtxLD1k5dR7zJIhGDIZ2e9Fmu7d7cOfmOLPclVGb2sdk+mcrStVU2cCRRQ+z7nXQqOwdXZ9qdsokqJiF/eL3B9XQ+sHQxM=
Message-ID: <9a87484905081013094ae72b56@mail.gmail.com>
Date: Wed, 10 Aug 2005 22:09:37 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Jon Scottorn <jscottorn@possibilityforge.com>
Subject: Re: Kernel panic 2.6.12.4
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <42FA5082.8080907@possibilityforge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42FA5082.8080907@possibilityforge.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/05, Jon Scottorn <jscottorn@possibilityforge.com> wrote:
> Hi,
> 
>    I am in need of some help!
> I have installed Debian which has 2.6.8-2 kernel on it.  After a fresh
> install I downloaded the 2.6.12.4 kernel and went to upgrade.  After
> making the necessary changes in menuconfig I rebuilt the kernel and
> install it.  It boots up until I get:
> Modules linked in:
> CPU:       0
> EIP:         0060:[c026d55d]   Not tainted VLI
> EFLAGS: 00010006    (2.6.12.4)
> EIP is at adpt_isr+0x178/0x1f5
> .......
> Cut out for space and time as I am typeing it all in.

The entire message would be helpful, as would the output from scripts/ver_linux


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
