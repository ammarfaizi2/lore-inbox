Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262648AbVAKJgD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262648AbVAKJgD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 04:36:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262708AbVAKJgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 04:36:01 -0500
Received: from mail.enyo.de ([212.9.189.167]:33468 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S262648AbVAKJfh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 04:35:37 -0500
From: Florian Weimer <fw@deneb.enyo.de>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: Diego Calleja <diegocg@gmail.com>, Steve Bergman <steve@rueb.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Proper procedure for reporting possible security vulnerabilities?
References: <41E2B181.3060009@rueb.com> <87d5wdhsxo.fsf@deneb.enyo.de>
	<41E2F6B3.9060008@rueb.com>
	<20050110230827.4d13ae7b.diegocg@gmail.com>
	<20050111001901.GA4378@ip68-4-98-123.oc.oc.cox.net>
Date: Tue, 11 Jan 2005 10:35:25 +0100
In-Reply-To: <20050111001901.GA4378@ip68-4-98-123.oc.oc.cox.net> (Barry
	K. Nathan's message of "Mon, 10 Jan 2005 16:19:01 -0800")
Message-ID: <87pt0cs3z6.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Barry K. Nathan:

> On Mon, Jan 10, 2005 at 11:08:27PM +0100, Diego Calleja wrote:
>> They could have mailed to *THIS* mailing list, so anyone can make a patch.
>
> And abandon the whole idea of coordinated disclosure?

For local vulnerabilities?  Get real.

Most users won't update anyway because they still believe that the
kernel team makes timely security releases, and they are safe as long
as they use the latest kernel.org release.  The current process
doesn't protect them.

(I know, they should use vendor kernels instead.)
