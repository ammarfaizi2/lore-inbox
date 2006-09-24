Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750753AbWIXN0e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbWIXN0e (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 09:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbWIXN0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 09:26:34 -0400
Received: from smtp-out001.kontent.com ([81.88.40.215]:57230 "EHLO
	smtp-out.kontent.com") by vger.kernel.org with ESMTP
	id S1750753AbWIXN0e convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 09:26:34 -0400
From: Oliver Neukum <oliver@neukum.org>
To: "Ryan Moszynski" <ryan.m.lists@gmail.com>
Subject: Re: /drivers/usb/class/cdc-acm.c patch question, please cc
Date: Sun, 24 Sep 2006 15:26:48 +0200
User-Agent: KMail/1.8
Cc: "David Kubicek" <dave@awk.cz>, linux-kernel@vger.kernel.org
References: <fbf7c10b0609221445q1329eb5bsfe304c02f7f336db@mail.gmail.com>
In-Reply-To: <fbf7c10b0609221445q1329eb5bsfe304c02f7f336db@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200609241526.48659.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 22. September 2006 23:45 schrieb Ryan Moszynski:
> since 2.6.14 i have been applying the following patch and recompiling
> my kernel so
> that i can use my verizon kpc650 evdo card with my laptop.  I've
> applied this patch
> succesfully on 2.6.14 and 2.6.15.  It works great and I have no problems.  I am
> trying to apply the patch to 2.6.18 but it fails, and i don't want to
> break anything,

First give me a description of your device. Secondly, we'll try
to find a generic solution. Thirdly, if nothing else helps, we'll add
a generic quirk to the driver.

	Regards
		Oliver
