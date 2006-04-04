Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751055AbWDDGB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbWDDGB5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 02:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbWDDGB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 02:01:57 -0400
Received: from nproxy.gmail.com ([64.233.182.186]:40336 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751055AbWDDGB5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 02:01:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=W7PBQ7vGfMBVm4XOOb3U7tRFGppuXQAFHjcAM2GWsEAxCMmSvmhCY6RpK/NcDfMx5SnIE1qhCz5/DYOU+a4GLbi8KTp2F2jKbfHWpUAeQ5mS/JtF7vrG/RRxOOsdtULVyhRR35LvRMjgSa5gFUda/TACoIoJn7Lv19W3aMhn2eE=
Date: Tue, 4 Apr 2006 10:01:56 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: menuconfig search (Re: [rfc] fix Kconfig, hotplug_cpu is needed for swsusp)
Message-ID: <20060404060156.GE16658@mipter.zuzino.mipt.ru>
References: <20060329220808.GA1716@elf.ucw.cz> <200603300936.22757.ncunningham@cyclades.com> <20060329154748.A12897@unix-os.sc.intel.com> <200603300953.32298.ncunningham@cyclades.com> <Pine.LNX.4.61.0603301022400.30783@yvahk01.tjqt.qr> <20060403221537.79bb3af9.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060403221537.79bb3af9.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2006 at 10:15:37PM -0700, Randy.Dunlap wrote:
> Re verbosity:  do you know that menuconfig search (/) takes regular
> expressions?  That could help someone limit the amount of output
> from it.

(Inability to jump from search screen directly to just found config option to
set/unset it AND verbose output) is broken. Verbose output solely is probably
not a big deal.

