Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261780AbVA3UqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbVA3UqM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 15:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261781AbVA3UqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 15:46:12 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:26674 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261780AbVA3UqH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 15:46:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=BtqGsraCqQBsriRqfGZFc7NlSxAgLUr1pMhsGQGv+k5tXBVcs2OuvE7GugaXmr6ocYYj0TgI2cTkieS/0jiJWkNiDTv+uLFqpvAgpJ5JtzofH3b2eCEbEU6sLlAMHQ28qWG1fcb9Y4LPPYQl4VI/aOB+BPHonjw/95Om0YIlkB0=
Message-ID: <9dda349205013012454719a29b@mail.gmail.com>
Date: Sun, 30 Jan 2005 15:45:04 -0500
From: Paul Blazejowski <diffie@gmail.com>
Reply-To: Paul Blazejowski <diffie@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.11-rc2-mm2
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <9dda349205012923347bc6a456@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9dda349205012923347bc6a456@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's another one, my USB keyboard is not functioning properly, ie.
the caps lock,scrlk and num lock lights are not on when these keys are
pressed and dmesg gets tons of spam for each key presses:

drivers/usb/input/hid-input.c: event field not found
drivers/usb/input/hid-input.c: event field not found
drivers/usb/input/hid-input.c: event field not found
drivers/usb/input/hid-input.c: event field not found
drivers/usb/input/hid-input.c: event field not found

Cheers,

Paul

-- 
FreeBSD the Power to Serve!
