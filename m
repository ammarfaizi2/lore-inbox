Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293648AbSCPB33>; Fri, 15 Mar 2002 20:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293654AbSCPB3S>; Fri, 15 Mar 2002 20:29:18 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:3837
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S293648AbSCPB3M>; Fri, 15 Mar 2002 20:29:12 -0500
Date: Fri, 15 Mar 2002 17:30:27 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dan Maas <dmaas@dcine.com>, Jeremy Jackson <jerj@coplanar.net>,
        linux-kernel@vger.kernel.org
Subject: Re: unwanted disk access by the kernel?
Message-ID: <20020316013027.GD363@matchmail.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Dan Maas <dmaas@dcine.com>, Jeremy Jackson <jerj@coplanar.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <005401c1cc51$ab6c3fe0$1a02a8c0@allyourbase> <E16lwyE-0004N7-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16lwyE-0004N7-00@the-village.bc.nu>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2002 at 07:02:30PM +0000, Alan Cox wrote:
> > By the way, if I enable 'APM makes CPU idle calls when idle,' I get a
> > constant stream of 'apm_do_idle failed (3)' messages. APM also doesn't seem
> > to be able to power the machine down... This is a Dell Inspiron 7500...
> > Maybe I should try ACPI?
> 
> ACPI is a bit experimental right now but if you want some fun then obviously
> the more people who break the ACPI code the better.

For my uses (basically just power down) ACPI has worked on 99% of my
machines (mix of pii & piii).
