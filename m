Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289655AbSBEQmc>; Tue, 5 Feb 2002 11:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289657AbSBEQmW>; Tue, 5 Feb 2002 11:42:22 -0500
Received: from dns.logatique.fr ([213.41.101.1]:22256 "HELO
	persephone.dmz.logatique.fr") by vger.kernel.org with SMTP
	id <S289655AbSBEQmF>; Tue, 5 Feb 2002 11:42:05 -0500
Content-Type: text/plain; charset=US-ASCII
From: Thomas Capricelli <tcaprice@logatique.fr>
To: Dave Jones <davej@suse.de>, Benjamin Pharr <ben@benpharr.com>
Subject: Re: choice Help Sections
Date: Tue, 5 Feb 2002 17:41:49 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020205054709.GA3245@hst000004380um.kincannon.olemiss.edu> <20020205141013.A24679@suse.de>
In-Reply-To: <20020205141013.A24679@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020205163931.4FBEE23CBB@persephone.dmz.logatique.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus wants us to fix this. And cml2 seems to me the right fix. Why should we 
loose some time fixing  this when cml2 is already here ? And I trust Eric 
enough he will maintain it better than that  old Configure.help was. No 
flamewar intended.

Thomas


On Tuesday 05 February 2002 14:10, Dave Jones wrote:
> On Mon, Feb 04, 2002 at 11:47:09PM -0600, Benjamin Pharr wrote:
>  > Has anyone else noticed the availability of only one help section in
>  > "choice" blocks when using make menuconfig (and others maybe?)?
>  > The best example of this is selection of "Processor family". No matter
>  > which option is highlighted when Help is selected, it always gives the
>  > help for CONFIG_M386.
>
>  Yes, the config tools still need some work. With Linus showing
>  no sign of merging CML2 or anything else in the near future,
>  someone knowledgable of how these work should probably take a
>  look at fixing them up.
