Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287449AbSAPUXi>; Wed, 16 Jan 2002 15:23:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287464AbSAPUXS>; Wed, 16 Jan 2002 15:23:18 -0500
Received: from natwar.webmailer.de ([192.67.198.70]:31987 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S287440AbSAPUXM>; Wed, 16 Jan 2002 15:23:12 -0500
Date: Wed, 16 Jan 2002 21:21:22 +0100
From: Kristian <kristian.peters@korseby.net>
To: "AstinusLists" <AstinusLists@netcabo.pt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ISDN CHANNEL-D
Message-Id: <20020116212122.2f6b7d7a.kristian.peters@korseby.net>
In-Reply-To: <001d01c19ec5$b6f8f740$d500a8c0@mshome.net>
In-Reply-To: <001d01c19ec5$b6f8f740$d500a8c0@mshome.net>
X-Mailer: Sylpheed version 0.6.6claws34 (GTK+ 1.2.10; i686-redhat-linux)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"AstinusLists" <AstinusLists@netcabo.pt> wrote:
> [..]
> I would like to know if any of u isdn driver hackers can point me out a way
> of how to build such a program or where to read some real good stuff about
> this ISDN-D channel.

If you're looking for drivers, please go to isdn4linux.de (or search for newsgroups that have "isdn4linux" in their title). As far as I know the current hisax drivers (which are included in the kernel as well) support d-channel. But the d channel is only meant for starting a connection, not to support whole traffic. And it is rather slow. So it would make no fun compared to 64kbs...
I can provide you an email address of one linux-guy from AVM. This (german) company is responsible for many active isdn cards and I think their drivers are supporting d-channel too.

*Kristian

·· · · reach me :: · ·· ·· ·  · ·· · ··  · ··· · ·
                         :: http://www.korseby.net
                         :: http://www.tomlab.de
kristian@korseby.net ....::
