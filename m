Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbWHNPSI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbWHNPSI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 11:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbWHNPSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 11:18:08 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6373 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750733AbWHNPSG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 11:18:06 -0400
Date: Mon, 14 Aug 2006 11:18:02 -0400
From: Dave Jones <davej@redhat.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Luke Sharkey <lukesharkey@hotmail.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: Touchpad problems with latest kernels
Message-ID: <20060814151802.GB3196@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Luke Sharkey <lukesharkey@hotmail.co.uk>,
	linux-kernel@vger.kernel.org
References: <BAY114-F2C4913B499BE3113C8E9BFA4E0@phx.gbl> <d120d5000608140736w4bc04e69ycbea97e5817ce584@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000608140736w4bc04e69ycbea97e5817ce584@mail.gmail.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2006 at 10:36:14AM -0400, Dmitry Torokhov wrote:
 > On 8/14/06, Luke Sharkey <lukesharkey@hotmail.co.uk> wrote:
 > > Dear Sir,
 > >
 > > I am emailing regarding some problems I have been having with the touchpad
 > > on my laptop (a hp pavilion dv5046ea  running Fedora Core 5 x86_64).
 > > [ Here are the specifications for my laptop:
 > > http://h10010.www1.hp.com/wwpc/uk/en/ho/WF06b/21675-38187-38191-38191-38191-12319008-69074479.html]
 > >
 > >
 > > Support for my touchpad seems to have gotten worse rather than better in
 > > successive kernels from 2054 onwards.
 > >
 > > While on 2054 it generally works fine, On the latest kernels (2154, 2174
 > > etc.)  I have only to e.g. open a konqueror window for the onscreen pointer
 > > to start going funny, and jerking about (As happens on computers with v. low
 > > RAM).  I know its not a RAM problem, as a) everything else works fine, there
 > > is no slow down of any of the programs I run, only problems with the mouse
 > > and b) I have just upgraded from 512 MB of RAM to 1 GB.
 > >
 > > If I plug in a mouse, the pointer works fine.  Though I would happily use a
 > > mouse, this is often inconvenient on a laptop.
 > >
 > 
 > What kind of touchpad is this? Are you using synaptics X driver or
 > standard mouse driver? Also I am not quire sure what 2054 or 2154 is.
 > Can you please try vanilla kernels from kernel.org?
 > 
 > Dave, is there a place where one can see contents of a given RH kernel
 > (without downloadig and unpacking SRPM)?

There are cvs instructions at http://people.redhat.com/davej
A link to cvsweb is also there.

Quick version number mapping, based on cvs annotate kernel-2.6.spec ..

2054 - 2.6.16-rc6-git3
2154 - 2.6.17.3
2174 - 2.6.17.8


		Dave

-- 
http://www.codemonkey.org.uk
