Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753814AbWKGWo1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753814AbWKGWo1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 17:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753816AbWKGWo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 17:44:27 -0500
Received: from wx-out-0506.google.com ([66.249.82.226]:21295 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1753814AbWKGWo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 17:44:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Rgp6IMoYSiByERKBIYQBzdQwVCCzXUvUCefBzbBmXKxHUhZkaELklOvcwDQ3KrNxK+z4IPu2X3OfJwnHUR7mEXRJMFT9q/pE8U3yKSt1YoGmeyFJ37yM9uVYx9YwCHTgR1xkr/LqaPQhEdtQJh/N93xfh9cd7wzz24/MXRJRE3w=
Message-ID: <b6a2187b0611071444y744c240fq13f4e0cb9cdb2da3@mail.gmail.com>
Date: Wed, 8 Nov 2006 06:44:26 +0800
From: "Jeff Chua" <jeff.chua.linux@gmail.com>
To: "Aaron Durbin" <adurbin@google.com>
Subject: Re: [PATCH] i386: Update MMCONFIG resource insertion to check against e820 map.
Cc: "Matthew Wilcox" <matthew@wil.cx>, linux-kernel@vger.kernel.org
In-Reply-To: <8f95bb250611071408x46d6fd1ejb6ef7c59a00f1cb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <8f95bb250611071408x46d6fd1ejb6ef7c59a00f1cb@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/06, Aaron Durbin <adurbin@google.com> wrote:
>
> Signed-off-by: Aaron Durbin <adurbin@google.com>
>
> This patch is against 2.6.19-rc4. It is only compile tested for i386,
> but it is the same patch as x86-64 that I previously submitted.

Tested on 2 different machines and MMCONFIG now works!

Thanks,
Jeff.
