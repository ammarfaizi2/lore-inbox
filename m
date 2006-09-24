Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751430AbWIXACe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbWIXACe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 20:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbWIXACe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 20:02:34 -0400
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:51159 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id S1751401AbWIXACd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 20:02:33 -0400
Date: Sun, 24 Sep 2006 02:02:19 +0200
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
To: Markus Rechberger <mrechberger@gmail.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net
Subject: Re: [Alsa-devel] snd-usb-audio problems with 2.6.18
Message-ID: <20060924000219.GA4679@hardeman.nu>
Mail-Followup-To: Markus Rechberger <mrechberger@gmail.com>,
	linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net
References: <20060923125456.GA7757@hardeman.nu> <d9def9db0609230623k6ccfedbp1cd5be8ec25d176d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
In-Reply-To: <d9def9db0609230623k6ccfedbp1cd5be8ec25d176d@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Content-Transfer-Encoding: 8BIT
X-SA-Score: -2.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 23, 2006 at 03:23:19PM +0200, Markus Rechberger wrote:
>this issue might be hidden within the usb subsystem.
>USB bandwidth allocation doesn't work 100% yet afaik, better turn off
>support for it when configuring your kernel.

Thanks, turning off bandwidth allocation fixed usb-audio again

-- 
David Härdeman
