Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267388AbSLRTFz>; Wed, 18 Dec 2002 14:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267389AbSLRTFz>; Wed, 18 Dec 2002 14:05:55 -0500
Received: from fmr04.intel.com ([143.183.121.6]:57280 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id <S267388AbSLRTFx>; Wed, 18 Dec 2002 14:05:53 -0500
Message-Id: <200212181913.gBIJDeP13012@unix-os.sc.intel.com>
Content-Type: text/plain; charset=US-ASCII
From: mgross <mgross@unix-os.sc.intel.com>
Reply-To: mgross@unix-os.sc.intel.com
Organization: SSG Intel
To: Arjan van de Ven <arjanv@redhat.com>
Subject: Re: Multithreaded coredump patch where?
Date: Wed, 18 Dec 2002 08:19:33 -0800
X-Mailer: KMail [version 1.3.1]
Cc: Roberto Fichera <kernel@tekno-soft.it>, linux-kernel@vger.kernel.org
References: <5.2.0.9.0.20021216182325.042a2b60@mail.isolaweb.it> <200212170015.gBH0FXP13878@unix-os.sc.intel.com> <1040127295.10437.5.camel@laptop.fenrus.com>
In-Reply-To: <1040127295.10437.5.camel@laptop.fenrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 December 2002 04:14 am, Arjan van de Ven wrote:
> On Mon, 2002-12-16 at 22:21, mgross wrote:
> > I don't know if there is any plan to back port Ingo's version of this
> > feature to 2.4.x
>
> the current Red Hat Rawhide kernels have an attempt for a backport but
> it's not fully working right yet unfortionatly

Is this because you are doing both the NPTL kernel support and the 
multi-threaded core dump in a combined back port making the effort more 
complex?

What types of issues are you seeing with the back port?

I'm just wondering.  These are cool features.

--mgross
