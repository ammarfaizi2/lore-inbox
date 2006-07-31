Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751453AbWGaXog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbWGaXog (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 19:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750976AbWGaXof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 19:44:35 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:40749 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750907AbWGaXof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 19:44:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=CPt1msLyPDqDtpXEXFqDfBqlYyPCaQ7wi7FlFwnVrJesXib1f7pjmNxCipRI7hV/F3E8SYWPjNJKPuDUUmXESkj3TsSgDSglAbWvShGedUz9GoofuoYKlYu4IPuxLfDR0PSTn2+GVM/xAeYoZrDTQTpSOcAoHGS+l67Rjx3G3xU=
Message-ID: <44CE95DD.1030102@gmail.com>
Date: Tue, 01 Aug 2006 07:44:29 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Edgar Hucek <hostmaster@ed-soft.at>, LKML <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, akpm@osdl.org
Subject: Re: [PATCH 1/3] add-imacfb-docu-and-detection.patch
References: <44CDBE5D.8020504@ed-soft.at> <20060731193254.GA31594@nineveh.rivenstone.net>
In-Reply-To: <20060731193254.GA31594@nineveh.rivenstone.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joseph Fannin wrote:
> On Mon, Jul 31, 2006 at 10:25:01AM +0200, Edgar Hucek wrote:
> 
>     So imacfb now defaults to off?  That would be good, especially
> since it cannot be a module, and doesn't work with the Apple "BIOS"
> stuff.
> 
>     If not, a video=imacfb:off option would be much appreciated.

Yes, this patch will support the above option too.

Tony
