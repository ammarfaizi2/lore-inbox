Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310370AbSCBMoI>; Sat, 2 Mar 2002 07:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310367AbSCBMnt>; Sat, 2 Mar 2002 07:43:49 -0500
Received: from AMontpellier-201-1-1-61.abo.wanadoo.fr ([193.252.31.61]:12562
	"EHLO awak") by vger.kernel.org with ESMTP id <S310366AbSCBMnm> convert rfc822-to-8bit;
	Sat, 2 Mar 2002 07:43:42 -0500
Subject: Re: [2.4.19-pre1-ac1] usbnet frames mangled
From: Xavier Bestel <xavier.bestel@free.fr>
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020302071545.GB20536@kroah.com>
In-Reply-To: <1015003428.2274.5.camel@bip> 
	<20020302071545.GB20536@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/1.0 (Preview Release)
Date: 02 Mar 2002 13:43:36 +0100
Message-Id: <1015073017.777.0.camel@bip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

le sam 02-03-2002 à 08:15, Greg KH a écrit :
> On Fri, Mar 01, 2002 at 06:23:48PM +0100, Xavier Bestel wrote:
> > 
> > which of course doesn't mean anything. I saw this behavior since I
> > upgraded my desktop from 2.4.18-ac2 to 2.4.19-pre1-ac1
> 
> So you kept your USB client at the same version, but your host changed
> versions?  And 2.4.18-ac2 works, but 2.4.19-pre1-ac1 doesn't?

That's it.

> Can you see if 2.4.19-pre2 works or not for you?

It works pretty well.

> And which USB host controller driver are you using?

uhci (not JE. I've compiled both as modules, but uhci seems to be used).

	Xav

