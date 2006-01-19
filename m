Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161219AbWASOvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161219AbWASOvu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 09:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161220AbWASOvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 09:51:50 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:5186 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161219AbWASOvt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 09:51:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TseGncwVGVMBxA3kozOOy5ZAvzjyEhaqz2/L2nBA33TjEuGtKRdpgto47o7DVwWKV3Y0feKIWwXGTAwnyQCHSQKUk2/ZJHya6SnZ/mvwSwO20Jf71ebfKVzHrqs5+kYICG+7pK9+g0V8Q0/AB8UqA+SNT0ljUgJWcL9B3BXIOBg=
Message-ID: <d120d5000601190651s63fa9413w2cb021c8e4682ec4@mail.gmail.com>
Date: Thu, 19 Jan 2006 09:51:48 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: [PATCH] Fix compile warning in bt8xx module
Cc: Russell King <rmk+kernel@arm.linux.org.uk>, Greg KH <greg@kroah.com>,
       Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1137667261.5754.3.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200601152332.54168.dtor_core@ameritech.net>
	 <1137667261.5754.3.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/06, Mauro Carvalho Chehab <mchehab@infradead.org> wrote:
> Dmitry,
>
>        Your patch conflicted with another one by Jean Delaware.
>
>        Please next time send dvb or v4l patches to me c/c to
> video4linux-list@redhat.com and linux-dvb-maintainer@linuxtv.org
>

My apologies. The original change did not come from your tree, it was
a wholesale tree update, that's why I sent it to patch originator.
Next time I will make sure to CC you and V4L/DVB lists.

--
Dmitry
