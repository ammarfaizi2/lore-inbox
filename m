Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423832AbWKHWjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423832AbWKHWjx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 17:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423833AbWKHWjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 17:39:53 -0500
Received: from nz-out-0102.google.com ([64.233.162.197]:1205 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1423832AbWKHWjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 17:39:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=T1h92p6IT+zCTuTzaOo2LY2EXaIhOjwdLh/WGMNc/Phk3BSu0VNf2R8TX2t18wPA7vfUxRC9O07GoUBPsQbPm8AMP3ufjIQBTZB9qqwwdFlT3XbaLf4EGEvuFxb2cz7CKh/EZEMO45y4+X2KhTzMMk85L8ZJAB8O1UfiFUKDJ2c=
Message-ID: <d9a083460611081439v2eacb065nef62f129d2d9c9c0@mail.gmail.com>
Date: Wed, 8 Nov 2006 23:39:50 +0100
From: Jano <jasieczek@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Problems with mounting filesystems from /dev/hdb (kernel 2.6.18.1)
Cc: "Jiri Slaby" <jirislaby@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 Lis, 22:50, Jiri Slaby <jirislaby@gmail.com> wrote:
>
> -127MB HIGHMEM available.
> +Warning only 896MB will be used.
> +Use a HIGHMEM enabled kernel.
>
> This has nothing to do with your problem, but I recommend you to enable HIGHMEM.
>

Done. Thanks.

>
> Sorry, it's not exact diff, but there were some line wraps.
>

As far as I'm not mistaken disabling timestamps would allow me to make
a precise diff, however I am afraid I would have to download and
recompile kernel sources from Ubuntu repos in order to ensure that the
compiled one is exactly similar to the binary one I'm currently using.

>
> Which ATA do you use (the prod or experimental)? Post a .config.
>

.config has been attached. I hope it contains an answer to your
question, because otherwise I wouldn't know where to search for this
information.

Best regards,
Jano
-- 
Mail 	jano at stepien com pl
Jabber 	jano at jabber aster pl
GG 	1894343
Web	stepien.com.pl
