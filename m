Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbTFJSvg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 14:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261151AbTFJSvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 14:51:25 -0400
Received: from air-2.osdl.org ([65.172.181.6]:45995 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261352AbTFJStW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:49:22 -0400
Date: Tue, 10 Jun 2003 12:00:39 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Rik van Riel <riel@redhat.com>
Cc: colin@colina.demon.co.uk, linux-kernel@vger.kernel.org
Subject: Re: Maximum swap space?
Message-Id: <20030610120039.31e8ee47.rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0306071827450.24170-100000@chimarrao.boston.redhat.com>
References: <ltptlqb72n.fsf@colina.demon.co.uk>
	<Pine.LNX.4.44.0306071827450.24170-100000@chimarrao.boston.redhat.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Jun 2003 18:28:46 -0400 (EDT) Rik van Riel <riel@redhat.com> wrote:

| On 7 Jun 2003, Colin Paul Adams wrote:
| 
| > I am somewhat confused about how much swap space you can have with a
| > 2.4 series kernel. If I read the mkswap man page, I get the impression
| > that I could have up to 8x2GB of swap space for a total of 16 GB, but
| > reading the RedHat reference guide, it says 2GB maximum.
| 
| That piece of documentation is out of date.  I'm using a
| 20 GB swap partition on one of my test systems, with a
| 2.4 kernel.

So do we know what the 2.4.current and 2.5.current limits are?

You have used a 20 GB swap partition on 2.4.recent.
Andrew has used (tested) a 52 GB partition on some unmentioned
kernel.

Thanks,
--
~Randy
