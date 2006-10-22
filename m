Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbWJVVWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbWJVVWz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 17:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750717AbWJVVWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 17:22:54 -0400
Received: from as3.cineca.com ([130.186.84.211]:34737 "EHLO as3.cineca.com")
	by vger.kernel.org with ESMTP id S1750723AbWJVVWy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 17:22:54 -0400
From: Luca Risolia <luca.risolia@studio.unibo.it>
To: Dave Jones <davej@redhat.com>
Subject: Re: sn9c10x list corruption in 2.6.18.1
Date: Sun, 22 Oct 2006 23:22:46 +0200
User-Agent: KMail/1.9.1
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <20061022031145.GA24855@redhat.com> <200610221346.53038.luca.risolia@studio.unibo.it> <20061022181539.GD27152@redhat.com>
In-Reply-To: <20061022181539.GD27152@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610222322.46703.luca.risolia@studio.unibo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle 20:15, domenica 22 ottobre 2006, Dave Jones ha scritto:
> But it only happens when the user unplugs the camera, and no other
> webcam driver seems to be affected by this problem.

Simply unplugging the camera does not reproduce any problem here. This is
the first time I see this bug.

> That's fairly conclusive to me that the driver is misbehaving.

I do not think this implication is correct, as not all the drivers are
implemented the same way and run under the same kernel configurations.

The code in the driver seems to be okay to me.

Best regards,
Luca
