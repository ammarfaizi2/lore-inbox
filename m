Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261491AbSJAFgx>; Tue, 1 Oct 2002 01:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261493AbSJAFgx>; Tue, 1 Oct 2002 01:36:53 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:40710 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261491AbSJAFgw>;
	Tue, 1 Oct 2002 01:36:52 -0400
Date: Mon, 30 Sep 2002 22:39:57 -0700
From: Greg KH <greg@kroah.com>
To: Steven Cole <elenstev@mesatop.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.39 Oops on boot (device_attach+0x3a)
Message-ID: <20021001053957.GA5177@kroah.com>
References: <1033434784.3100.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1033434784.3100.10.camel@localhost.localdomain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2002 at 07:13:02PM -0600, Steven Cole wrote:
> I tried to boot 2.5.39 on my home machine and got the
> following oops on boot with CONFIG_KALLSYMS=y (thanks Ingo!).

Do you have CONFIG_ISAPNP enabled?  If so, search the archives for the
fix for this.  If not, please post your whole .config.

thanks,

greg k-h
