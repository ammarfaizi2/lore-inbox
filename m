Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932114AbWHBVHj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbWHBVHj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 17:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbWHBVHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 17:07:39 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:21585 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932114AbWHBVHi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 17:07:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bjQzgPiiHtXtu3+5zeZItOqBVje7oJBB/xz/0fBSXGZmKgO0C+QDH/CzfWRD2OTrdP7HDQokO/ApqyT/Hvql8I9Hd8lz5u+p1a0lY3CLk1vQG7T9KrHjrjc0k/BP8uLzMPIfXp5bSHIqUDBZCepkMIYRh0KKGkdUW6wGz+Inhck=
Message-ID: <625fc13d0608021407q45c9baa0o66ea33b382eb17ef@mail.gmail.com>
Date: Wed, 2 Aug 2006 16:07:36 -0500
From: "Josh Boyer" <jwboyer@gmail.com>
To: "Pavel Machek" <pavel@suse.cz>
Subject: Re: driver for thinkpad fingerprint sensor
Cc: "kernel list" <linux-kernel@vger.kernel.org>, vojtech@suse.cz
In-Reply-To: <20060802203925.GA13899@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060802203925.GA13899@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/06, Pavel Machek <pavel@suse.cz> wrote:
> Hi!
>
> Here's GPLed driver for thinkpad fingerprint sensor. It is in
> userspace -- for now, but it is so simple it could be easily moved
> into kernel (everything is done in hardware).
>
> Questions are:
>
> *) should it be kernel or userspace?
>
> *) can someone test it/fix it on X41 and similar models? It works okay
> on x60.
>
> *) are there other similar sensors? I know one in-kernel driver that
> produces images, this is quite different.

The z60m has a sensor as well.  I give this a shot soon and see if it works.

josh
