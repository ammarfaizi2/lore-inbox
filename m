Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031861AbWLGIy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031861AbWLGIy2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 03:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031867AbWLGIy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 03:54:28 -0500
Received: from wx-out-0506.google.com ([66.249.82.233]:36033 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031861AbWLGIy0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 03:54:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cF4MMg68uq+icQTlAy8P9OfZT0pKPyTyJrL+vktl9j7z7FfwCEGcJ1sIijDtzCE0eG7j8YFLc8Ny3e//SQBshkp/RIZeHUndobNoZG3tsvq6xm06t1TkxWajhHVkcvKQUGEBUkIxReX/QHWKsUh8VvYSbS7auGBImPyxinL/M4M=
Message-ID: <9a8748490612070054k7f66ed2dsfd32698d38a7dd38@mail.gmail.com>
Date: Thu, 7 Dec 2006 09:54:26 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Randy Dunlap" <randy.dunlap@oracle.com>
Subject: Re: [PATCH/RFC] CodingStyle updates
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
In-Reply-To: <20061207004838.4d84842c.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061207004838.4d84842c.randy.dunlap@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/06, Randy Dunlap <randy.dunlap@oracle.com> wrote:
> From: Randy Dunlap <randy.dunlap@oracle.com>
>
> Add some kernel coding style comments, mostly pulled from emails
> by Andrew Morton, Jesper Juhl, and Randy Dunlap.
>
> - add paragraph on switch/case indentation
> - add paragraph on multiple-assignments
> - add more on Braces
> - add section on Spaces
> - add paragraph on function breaks in source files
> - add paragraph on EXPORT_SYMBOL placement
> - add section on /*-comment style, long-comment style, and data
>   declarations and comments
> - correct some chapter number references that were missed when
>   chapters were renumbered
>
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>

Acked-by: Jesper Juhl <jesper.juhl@gmail.com>


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
