Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030265AbVKVX6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030265AbVKVX6Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 18:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030266AbVKVX6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 18:58:25 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:8496 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030265AbVKVX6Y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 18:58:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qybY0iIHLCOjRjgikkffhuFoQa4sOtsTnKT0XFV+3oD8R9ZvaZ5GhbpXY0nKpOxf59CzT3KvGtYcMdFOrkBDXahXSvLFZ4yUAHx6UjYVmqxat4W2pEP78HZ7y6zjk/W19e5f6WFO0lkGKhpWvIi3QePNhqFyfOVUyk2uIMZ02yM=
Message-ID: <9e4733910511221558o4eb493cdhfef81e632c5306e7@mail.gmail.com>
Date: Tue, 22 Nov 2005 18:58:08 -0500
From: Jon Smirl <jonsmirl@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Christmas list for the kernel
Cc: Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1132702505.20233.88.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9e4733910511221031o44dd90caq2b24fbac1a1bae7b@mail.gmail.com>
	 <20051122204918.GA5299@kroah.com>
	 <9e4733910511221313t4a1e3c67wc7b08160937eb5c5@mail.gmail.com>
	 <1132702505.20233.88.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Maw, 2005-11-22 at 16:13 -0500, Jon Smirl wrote:
> > All of the legacy stuff - VGA, Vesafb, PS2, serial, parallel,
>
> PCI Parallel and serial hotplug
> PS2 hotplugs if you've got hotpluggable PS2 - I've even used this
> Most Joysticks hotplug
> Gameports mostly hotplug
> VESAfb is by definition not hotplug capable
> VGA hotplug we don't do but you can load the module.

The devices that plug into the ports hotplug, but the existence of the
ports themselves does not autodetect/hotplug at boot time.

>
>
> Alan
>
>


--
Jon Smirl
jonsmirl@gmail.com
