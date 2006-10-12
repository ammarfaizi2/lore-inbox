Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751254AbWJLWig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbWJLWig (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 18:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbWJLWig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 18:38:36 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:3302 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751254AbWJLWif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 18:38:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FHXNMiFEXbbiB11rTN811mj4pw72jta8i9y7irS+3cGXuhl1rV2otNtX8a91PuUvXsqXL/Bz3S5yDqwpHFWOs102XgBbDnPf67u8AtcZS5F99wGIfla3lI5FhtUn1LuOPAzWvT0vGUEZRXV44xJrjSZUY/ihDC0hOzV63e57wY4=
Message-ID: <653402b90610121538q215efb69oc66b455c0d93f71f@mail.gmail.com>
Date: Fri, 13 Oct 2006 00:38:33 +0200
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [PATCH 2.6.19-rc1 update 2] drivers: add LCD support
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061012145422.65958578.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061012140422.93e7330c.maxextreme@gmail.com>
	 <20061012145422.65958578.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/06, Andrew Morton <akpm@osdl.org> wrote:
> On Thu, 12 Oct 2006 14:04:22 +0000
> Miguel Ojeda Sandonis <maxextreme@gmail.com> wrote:
>
> > Andrew, here it is the patch for converting the cfag12864b driver
> > to a framebuffer driver as Pavel requested and as I promised :)
>
> I'm all confused.  This patch patches drivers/auxdisplay/fbcfag12864b.c,
> but there's no file of that name in any patches I have.
>
> I'll drop everything - please send a shiny new patch against current Linus
> mainline, thanks.
>

No problem, will do.
