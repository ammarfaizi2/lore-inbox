Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbVLBQMH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbVLBQMH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 11:12:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbVLBQMH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 11:12:07 -0500
Received: from zproxy.gmail.com ([64.233.162.199]:64359 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750801AbVLBQMG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 11:12:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DU1LWXTdT6vdyg6M0ma0QmUjkTDgCuZbT8JmsKmKhEBUdkTHvfb6HnDOvC+3knRyEBxAhYckw3xLLSVlIIJZUbVmf+bR6QJxRxUo9OGEUfCqjrpl/Q7pYvVQE9z4QZGfegkokZMki0OBDalOUrdviMLqjPAgstb7rdIqJPahfKc=
Message-ID: <75b07c990512020812i3c9fc3d0j@mail.gmail.com>
Date: Fri, 2 Dec 2005 16:12:05 +0000
From: Daniel Cadete <denarfhork@gmail.com>
To: "Ju, Seokmann" <Seokmann.Ju@engenio.com>
Subject: Re: How to setup git
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E5703662C65@exa-atlanta>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <0E3FA95632D6D047BA649F95DAB60E5703662C65@exa-atlanta>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12/05, Ju, Seokmann <Seokmann.Ju@engenio.com> wrote:
> [root@dhcp root]# rpm-ihv git-core-0.99.7-1.i386.rpm
> error: Failed dependencies:
>         perl(String::ShellQuote) is needed by git-core-0.99.7-1.i386
>         python >= 2.4 is needed by git-core-0.99.7-1.i386
>
> Where can I find those modules?

Google could help you...
I think that lkml its not the right place to ask these questions..
