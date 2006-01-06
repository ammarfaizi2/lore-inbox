Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932341AbWAFAk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbWAFAk2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 19:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932339AbWAFAk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 19:40:28 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:30475 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932338AbWAFAk0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 19:40:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oeo4Mu4iecN/d8YqWVeXXdFJwoUEfoyXTVLh4OGS2O6BjXywZXSrH1lTAq63Y2PsETeX2ZJxIjBa3rDiPRXpc2o7DthbZbYe2XCozsV1D8VaL4MeBll/JVRCjr+4dsOFd+Trq77Tkf/lN7M8jIG2l6oNsyw0Ft18SYOlEUAqHjQ=
Message-ID: <6bffcb0e0601051640g3c4d727bl@mail.gmail.com>
Date: Fri, 6 Jan 2006 01:40:25 +0100
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: 2.6.15-mm1: what's page_owner.c doing in Documentation/ ???
Cc: Andrew Morton <akpm@osdl.org>, LKML List <linux-kernel@vger.kernel.org>
In-Reply-To: <9a8748490601051624u36fb03d2l349c40a0165cbddb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9a8748490601051624u36fb03d2l349c40a0165cbddb@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06/01/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> Just wondering what page_owner.c is doing in Documentation/ in 2.6.15-mm1 ;-)
>
> $ ls -l linux-2.6.15-mm1/Documentation/page_owner.c
> -rw-r--r--  1 juhl users 2587 2006-01-05 18:15
> linux-2.6.15-mm1/Documentation/page_owner.c
>

It's simple - if you want page_owner documentation you can just read
the source code ;)

Regards,
Michal Piotrowski
