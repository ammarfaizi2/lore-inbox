Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754347AbWK1Uxr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754347AbWK1Uxr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 15:53:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754250AbWK1Uxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 15:53:47 -0500
Received: from wr-out-0506.google.com ([64.233.184.237]:9366 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1754075AbWK1Uxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 15:53:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=te0xh1pK5AiKdGBs+RlJkjuk7pMZZb92oqVg+zAJKb/dQbyC7iej37MvlBGnAXJdi872DCz9THzbrEk03Gsv78GiJY3NB9ljGhwEW/wOpDrm6Nd3+fTZHZvOloSKxfnB95fYxYiVX29oq6u9id+hgdtJDlbRU6SOZqfC8/3qsfI=
Message-ID: <9a8748490611281253m788d917gac62127f36da4c11@mail.gmail.com>
Date: Tue, 28 Nov 2006 21:53:45 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Randy Dunlap" <randy.dunlap@oracle.com>
Subject: Re: [PATCH] REPORTING-BUGS: request .config file
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
In-Reply-To: <20061128113522.432889b7.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061128113522.432889b7.randy.dunlap@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/06, Randy Dunlap <randy.dunlap@oracle.com> wrote:
> From: Randy Dunlap <randy.dunlap@oracle.com>
>
> Add kernel .config file to REPORTING-BUGS.
>
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>

Given how often people ask for the config, it makes good sense to have
that in the document.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
