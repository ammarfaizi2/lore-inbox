Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262654AbVAKBRS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262654AbVAKBRS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 20:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262644AbVAKBPC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 20:15:02 -0500
Received: from rproxy.gmail.com ([64.233.170.195]:45540 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262703AbVAKBJT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 20:09:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=W9XUr9MPxVZXP8yvZBBx02OkpFGG2VEUP4F2/ZV4+vypR9E4AcmS+lS9M61EG4kK9ZAX8lVQvYzqwi0DDa7D+Bb9XT+YPicx5nZR0AifqyqaBh9V+WQ/BitwIpEsI+F5DvVYRXBXlCXaIe1Am1M0yie9qJMDLKNPEHQkPK2L95A=
Date: Tue, 11 Jan 2005 02:09:31 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Chris Wright <chrisw@osdl.org>
Cc: juhl-lkml@dif.dk, steve@rueb.com, linux-kernel@vger.kernel.org
Subject: Re: Proper procedure for reporting possible security
 vulnerabilities?
Message-Id: <20050111020931.3acbf4b9.diegocg@gmail.com>
In-Reply-To: <20050110164001.Q469@build.pdx.osdl.net>
References: <41E2B181.3060009@rueb.com>
	<87d5wdhsxo.fsf@deneb.enyo.de>
	<41E2F6B3.9060008@rueb.com>
	<Pine.LNX.4.61.0501102309270.2987@dragon.hygekrogen.localhost>
	<20050110164001.Q469@build.pdx.osdl.net>
X-Mailer: Sylpheed version 1.0.0rc (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Mon, 10 Jan 2005 16:40:02 -0800 Chris Wright <chrisw@osdl.org> escribió:

> Problem is, the rest of the world uses a security contact for reporting
> security sensitive bugs to project maintainers and coordinating
> disclosures.  I think it would be good for the kernel to do that as well.

(somewhat OT..)

Perhaps it's just me, but i think it'd be nice that a new kernel version is
released every time a security issue is found.

Yes, vendors update their kernels themselves, but there's a *lot* of people
in linux who run kernel.org kernels, and it's hopefully to keep working
that way.

Those people  can also update themselves their kernel, also true. But the
security issues found in linux are not announced anywhere but mailing list
and sites like slashdot. Many people who run kernels from kernel.org don't
read slashdot or mailing lists and don't that there's a need of updating their
kernels. A new kernel version every time a security issue is found would help
for those people, or at least a "security updates" section in kernel.org's
webpage. Right now there's no "official" way of announcing those updates, and
I think it's a serious lack for a OS which is so widely used.
