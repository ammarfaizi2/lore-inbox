Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266121AbRGFHwp>; Fri, 6 Jul 2001 03:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265933AbRGFHwf>; Fri, 6 Jul 2001 03:52:35 -0400
Received: from front4m.grolier.fr ([195.36.216.54]:59371 "EHLO
	front4m.grolier.fr") by vger.kernel.org with ESMTP
	id <S266121AbRGFHwX>; Fri, 6 Jul 2001 03:52:23 -0400
Subject: Re: [OT] Maintainers master list: new idea
From: Xavier Bestel <xavier.bestel@free.fr>
To: Marc Brekoo <m_brekoo@mailandnews.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01e901c105a5$a0205220$0100a8c0@chello.nl>
In-Reply-To: <01e901c105a5$a0205220$0100a8c0@chello.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.10.99 (Preview Release)
Date: 06 Jul 2001 09:47:48 +0200
Message-Id: <994405675.5488.2.camel@nomade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have another suggestion for the MAINTAINER list:

Put the filenames/directories the maintainer is responsible of, perhaps
in a hierarchical tree (X maintains usb drivers, Y maintains usb
keyboards, Z maintains usb keyboard from such vendor).
This should be coherent and easily parsable.

This way, someone which has to send several patches can make a little
script which finds the correct maintainers to send its stuff to.
I've already been in that situation, currently it's a pain.

Xav

