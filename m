Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261783AbRE1Xlq>; Mon, 28 May 2001 19:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261800AbRE1Xlg>; Mon, 28 May 2001 19:41:36 -0400
Received: from [203.34.97.3] ([203.34.97.3]:38157 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S261783AbRE1XlT>;
	Mon, 28 May 2001 19:41:19 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: George France <france@handhelds.org>
cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jay Thorne <Yohimbe@userfriendly.org>
Subject: Re: PATCH - ksymoops on Alpha - 2.4.5-ac3 
In-Reply-To: Your message of "Mon, 28 May 2001 17:05:45 -0400."
             <01052817054503.17841@shadowfax.middleearth> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 29 May 2001 09:40:02 +1000
Message-ID: <4172.991093202@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 May 2001 17:05:45 -0400, 
George France <france@handhelds.org> wrote:
>Here is a trivial patch that will make ksymoops work again on Alpha.

Thanks for that.  Now if you can just persuade the Alpha people to
print the 'Code:' line in the same format as other architectures then
ksymoops can decode the instructions as well.  If Alpha wants to
include its own instruction decoder as well then that is up to them but
I would appreciate a standard 'Code:' line being printed first.

