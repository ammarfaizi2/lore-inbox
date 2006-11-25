Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967133AbWKYTZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967133AbWKYTZN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 14:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967139AbWKYTZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 14:25:13 -0500
Received: from smtp.osdl.org ([65.172.181.25]:9941 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S967133AbWKYTZL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 14:25:11 -0500
Date: Sat, 25 Nov 2006 11:24:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Benoit Boissinot" <bboissin@gmail.com>
Cc: "Larry Finger" <Larry.Finger@lwfinger.net>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19-rc5-mm1 progression
Message-Id: <20061125112437.3d46eff4.akpm@osdl.org>
In-Reply-To: <40f323d00611240836q6bcf7374gd47c7a97d1d4f8e3@mail.gmail.com>
References: <456718F6.8040902@lwfinger.net>
	<40f323d00611240836q6bcf7374gd47c7a97d1d4f8e3@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Nov 2006 17:36:27 +0100
"Benoit Boissinot" <bboissin@gmail.com> wrote:

> On 11/24/06, Larry Finger <Larry.Finger@lwfinger.net> wrote:
> > Is there the equivalent of 'git bisect' for the -mmX kernels?
> >
> http://www.zip.com.au/~akpm/linux/patches/stuff/bisecting-mm-trees.txt
> 

Please take the time to do that.  Yours is an interesting report - I'm not
aware of anything in there which was expected to cause a change of this
mature.
