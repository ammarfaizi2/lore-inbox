Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262508AbVE0RLZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262508AbVE0RLZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 13:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262509AbVE0RLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 13:11:25 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:61928 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262508AbVE0RLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 13:11:23 -0400
Subject: Re: Linux 2.6.11.11
From: Lee Revell <rlrevell@joe-job.com>
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       stable@kernel.org
In-Reply-To: <20050527160437.GL23013@shell0.pdx.osdl.net>
References: <20050527160437.GL23013@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Fri, 27 May 2005 13:11:22 -0400
Message-Id: <1117213882.13829.73.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-05-27 at 09:04 -0700, Chris Wright wrote:
> Gregor Jasny:
>   o usbusx2y: prevent oops & dead keyboard on usb unplugging while the device is being used
>   o usbaudio: prevent oops & dead keyboard on usb unplugging while the device is being used

Um, Karsten Wiese is the author of this patch.  Someone must have signed
off on it incorrectly, presumably the person who submitted it for
-stable.

Lee

