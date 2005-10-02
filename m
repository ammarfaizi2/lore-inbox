Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751150AbVJBTAa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbVJBTAa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 15:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbVJBTAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 15:00:30 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:64634 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751150AbVJBTAa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 15:00:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=f1dxi+FUgDU+Xb4oooI+nUs7M1Yqy56yuDicpy1nEmVa82kvqtXBxQQskVqs2+Ds+hg6FE5lhG3aYFcpVf4oW7KZCDYdhCFG8Mbv4Cw27OaFYBl7Rqt774OAKpG7DDqMMsGkQfoRyF+Jaf0/tUb0bIfm8ZbOzNlzudbixWYBgks=
Message-ID: <35fb2e590510021200m7f9be1bdk1033b39c46206e20@mail.gmail.com>
Date: Sun, 2 Oct 2005 20:00:29 +0100
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: Tiesto Tijs <t.tijs@freemail.hu>
Subject: Re: Linux gains lossless filesystem
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <freemail.20050830202325.14420@fm02.freemail.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <freemail.20050830202325.14420@fm02.freemail.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/05, Tiesto Tijs <t.tijs@freemail.hu> wrote:

> i would like to know, what is your opinion about this
> filesystem:

> http://www.linuxdevices.com/news/NS9521569196.html

Why wasn't it possible to make device mapper do what they wanted in
combination with modifying the journalling behaviour of an existing
fs?

Jon.
