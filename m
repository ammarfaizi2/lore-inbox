Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750905AbVKVDgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbVKVDgv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 22:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750850AbVKVDgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 22:36:51 -0500
Received: from smtp111.sbc.mail.re2.yahoo.com ([68.142.229.94]:12655 "HELO
	smtp111.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750770AbVKVDgu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 22:36:50 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Josh Boyer <jwboyer@gmail.com>
Subject: Re: [PATCH] Add more SCM trees to MAINTAINERS
Date: Mon, 21 Nov 2005 22:36:42 -0500
User-Agent: KMail/1.8.3
Cc: scjody@steamballoon.com, gregkh@suse.de, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
References: <625fc13d0511211911j10f8e87dha9be0b71a298c60d@mail.gmail.com>
In-Reply-To: <625fc13d0511211911j10f8e87dha9be0b71a298c60d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200511212236.43551.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 November 2005 22:11, Josh Boyer wrote:
>  IDE/ATAPI CDROM DRIVER
> @@ -1279,6 +1286,7 @@ P:        Vojtech Pavlik
>  M:     vojtech@suse.cz
>  L:     linux-input@atrey.karlin.mff.cuni.cz
>  L:     linux-joystick@atrey.karlin.mff.cuni.cz
> +T:     git kernel.org:/pub/scm/linux/kernel/git/dtor/input.git
>  S:     Maintained

This one is not really the official input tree as it is maintained by
myself, not Vojtech. He is currently publishes his quilt patchset
(a bit dated though) at:

	http://www.ucw.cz/~vojtech/input/

-- 
Dmitry
