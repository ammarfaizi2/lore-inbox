Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311329AbSCLUVj>; Tue, 12 Mar 2002 15:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311330AbSCLUV3>; Tue, 12 Mar 2002 15:21:29 -0500
Received: from pop.gmx.net ([213.165.64.20]:41346 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S311329AbSCLUVT>;
	Tue, 12 Mar 2002 15:21:19 -0500
Message-ID: <3C8E6333.A8B36DDC@gmx.net>
Date: Tue, 12 Mar 2002 21:21:07 +0100
From: Gunther Mayer <gunther.mayer@gmx.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] My AMD IDE driver, v2.7
In-Reply-To: <Pine.LNX.4.33.0203111638290.26250-100000@home.transmeta.com> <3C8D5CCD.3050208@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> Linus, would it be acceptable to you to include an -optional- filter for
> ATA commands?  There is definitely a segment of users that would like to
> firewall their devices, and I think (as crazy as it may sound) that
> notion is a valid one.

A perfect filter exists already: it's called "non-root user" :-)


