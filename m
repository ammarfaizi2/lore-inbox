Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752179AbWCOXpu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752179AbWCOXpu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 18:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752180AbWCOXpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 18:45:50 -0500
Received: from mx1.redhat.com ([66.187.233.31]:43168 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752179AbWCOXpt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 18:45:49 -0500
Date: Wed, 15 Mar 2006 18:44:21 -0500
From: Alan Cox <alan@redhat.com>
To: Linux and Kernel Video <video4linux-list@redhat.com>
Cc: "'Mauro Carvalho Chehab'" <mchehab@infradead.org>,
       Adrian Bunk <bunk@stusta.de>, linux-usb-devel@lists.sourceforge.net,
       usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org,
       v4l-dvb-maintainer@linuxtv.org, mdharm-usb@one-eyed-alien.net
Subject: Re: [usb-storage] Re: [v4l-dvb-maintainer] 2.6.16-rc: saa7134 + u sb-storage = freeze
Message-ID: <20060315234421.GB4414@devserv.devel.redhat.com>
References: <820212CF2FD63647B52A8F64B35352B20B942298@essomaexc1.essvote.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <820212CF2FD63647B52A8F64B35352B20B942298@essomaexc1.essvote.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2006 at 03:24:40PM -0600, Ballentine, Casey wrote:
> I would bet we could add the vt8235 to the list of broken chipsets 
> as well, if it's not already there.  My company has completely 

"Works for me" 8)

A lot of this is BIOS dependant and if we can isolate cases where one
BIOS works and another doesn't an lspci -vvxxx would be helpful so we
can look for chipset pokery

