Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932385AbWCMJYV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385AbWCMJYV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 04:24:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932388AbWCMJYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 04:24:21 -0500
Received: from ns.firmix.at ([62.141.48.66]:64175 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S932385AbWCMJYU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 04:24:20 -0500
Subject: RE: [future of drivers?] a proposal for binary drivers.
From: Bernd Petrovitsch <bernd@firmix.at>
To: davids@webmaster.com
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKGEMOKKAB.davids@webmaster.com>
References: <MDEHLPKNGKAHNMBLJOLKGEMOKKAB.davids@webmaster.com>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Mon, 13 Mar 2006 10:24:17 +0100
Message-Id: <1142241857.19650.27.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-03-12 at 21:16 -0800, David Schwartz wrote:
> > I'm not sure how the analogy of a toilet fits either the linux kernel
> > or the idea that I'm somehow obligated to work without compensation so
> > some corporation can make a profit I get no share in.
> 
> 	You are not obligated to work without compensation or to let some
> corporation use your work to make a profit that you get no share in.
> However, if you choose to give your work away without first getting an
> agreement from the recipient, you are willingly giving up lots of control
> that you would otherwise have.
> 
> 	I would strongly caution you against believing anyone who tells you
> different, no matter how much you want to hear it. The facts are:
> 
> 	1) A person who lawfully acquires a work without agreeing otherwise gains
> the right to the ordinary and expected use of that work.

... under the given conditions/rules/license/contract/etc. If you
lawfully buy MSFT software, you are probably also limited by your
contract (as long as the given limitations do not conflict with laws
under the jurisdiction you bought and/or live - more or less IANAL).

[ irrelevant library stuff removed ]

> 	3) The ordinary and expected use of the RedHat 'linux-kernel' package is to
> develop kernel drivers and produce binaries of them.

Since you got the package from RedHat (or subsidiaries or several people
in between), you are bound by the GPL since neither RedHat nor the
several people in between as any different access to the kernel-sources
than via GPL. And they can't change it.
So you got it under the rules of the GPL.

> 	4) Copyright does not allow you to own every way to do some specific thing,

Copyright/authors rights allows me to own *my way* of doing it. And if
you derive your work on mine, it depends on the quality and quantity
*if* you have any copyright/authors rights on you patch and how the
joined work must be treated legally.
In the Linux kernel, dozens (if not hundreds) of people have
copyrighted/authored righted code in there so.

> you need a patent for that. Any application that uses library X or any
> driver for kernel Y is a specific thing. Copyright only applies when there

If there was a binary in-kernel API, yes.
But a) there is no "officially" one and b) we have no "libraries" (in
the sense of the GPL) here.

> are numerous ways to do the same thing or express the same idea. Drivers for
> different operating systems are different ideas. You cannot use copyright to
> lock out someone from doing a particular thing, only from doing that thing
> the same way you did.

No, you can't even lock someone out to do the same thing. You can only
lock someone out to base his thing on your thing (but you can't hinder a
reimplementation - you need a patent for this [and a jurisdiction which
allows software patents]).

> 	5) There is no right under copyright for authors of original works to limit
> the distribution of lawfully-created derivative works to those with the
> right to use the original work.

Maybe not under (US-American) copyright, but under continental European
authors rights there are such possibilities (I leave it to lawyers if
and when they apply) and you can't even remove them with contracts (as
with all law stuff).

> 	6) All of this is copyright law and applies whether or not anyone agrees to
> the GPL or any other agreement, so nothing those agreements says can change
> this.

This is a common misunderstanding: If you change the rules of the GPL,
you automatically loose all rights you received with the GPL[0]

	Bernd

[0]: If you believe the wording of the GPL. Lawyers may think different.
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

