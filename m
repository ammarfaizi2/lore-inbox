Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282224AbRKWTo0>; Fri, 23 Nov 2001 14:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282216AbRKWToQ>; Fri, 23 Nov 2001 14:44:16 -0500
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:43141 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S282213AbRKWTn4>;
	Fri, 23 Nov 2001 14:43:56 -0500
Message-ID: <3BFEA6F1.33E3F1BF@pobox.com>
Date: Fri, 23 Nov 2001 11:43:45 -0800
From: J Sloan <jjs@pobox.com>
Organization: J S Concepts
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.15-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: war <war@starband.net>
CC: Roy Sigurd Karlsbakk <roy@karlsbakk.net>, linux-kernel@vger.kernel.org
Subject: Re: Which gcc version?
In-Reply-To: <20011123125137Z282133-17408+17815@vger.kernel.org> <3BFE5447.3AFDFFD3@starband.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually there is no need to go download yet
another compiler -

The gcc-2.96 shipped with redhat will work
perfectly for compiling your kernel -

See Documentation/Changes, line 87 for a
heads-up

cu

jjs

war wrote:

> You should use gcc-2.95.3.
>
> Roy Sigurd Karlsbakk wrote:
>
> > hi all
> >
> > I just wonder...
> > With a clean rh72 install, I've got two gcc versions installed in parllel,
> > 2.96 and 3.0.2. Which one should I use to compile the kernel?

