Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315799AbSEEA4x>; Sat, 4 May 2002 20:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315800AbSEEA4w>; Sat, 4 May 2002 20:56:52 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:45502 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S315799AbSEEA4w>;
	Sat, 4 May 2002 20:56:52 -0400
Date: Sun, 5 May 2002 10:54:39 +1000
From: Anton Blanchard <anton@samba.org>
To: Dan Kegel <dank@kegel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: khttpd newbie problem
Message-ID: <20020505005439.GA12430@krispykreme>
In-Reply-To: <3CD402D2.E3A94CA2@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Dan,

> I'm having an oops with khttpd on an embedded 2.4.17 ppc405
> system, so I thought I'd try it out on my pc.  But I can't
> get khttpd to serve any requests.

Any reason for not using tux? Its been tested heavily on ppc64,
the same patches should work on ppc32.

Anton
