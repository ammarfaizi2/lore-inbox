Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030221AbWBGW5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030221AbWBGW5S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 17:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030227AbWBGW5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 17:57:18 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:58416 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030221AbWBGW5R convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 17:57:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jjjRsbf5N34kL69RxwYCMVkuD19DfgNJdQYbBU+VOxCw1cJOfiTnLrmH6QWcXi9vlDuMzOmVoYiA2mJ6hHREsUCZF3DiqYAZENR+fT3jwCakMKxzKOVuAaD9d8iz+W4ksq92cKmDZO4t35Ts5aWIzolvBDaY3st6sU2HebhUOVw=
Message-ID: <9a8748490602071457n64d5cd77o7821fb09d2b80c68@mail.gmail.com>
Date: Tue, 7 Feb 2006 23:57:16 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: alex-lists-linux-kernel@yuriev.com
Subject: Re: non-fakeraid controllers
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060207015126.GA12236@s2.yuriev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060207015126.GA12236@s2.yuriev.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/06, alex-lists-linux-kernel@yuriev.com
<alex-lists-linux-kernel@yuriev.com> wrote:
> Hi,
>
>         This is not an attempt to start a religious flamewar about what is
> RAID vs. what is softraid vs. what is fakeraid.
>
>         Does anyone has a list/refence/etc on reasonably modern SCSI
> controllers (at least u160) in a non-fakeraid way i.e. the way that would
> allow linux to boot from a RAID protected disk array when one of the drives
> in the array failed even if the root filesystem is located on the same
> array?
>

Personally I have very good exeriences with Linux & IBM ServeRAID
controllers (especially the ServeRAID-5i, ServeRAID-5M & ServeRAID-6M)
as well as HP's Integrated Smart Array 6i controller in their ProLiant
DL380 G4 servers.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
