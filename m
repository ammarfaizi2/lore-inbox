Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271498AbTGQPUp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 11:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271497AbTGQPUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 11:20:24 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63877 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S271494AbTGQPT2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 11:19:28 -0400
Message-ID: <3F16C1F3.40206@pobox.com>
Date: Thu, 17 Jul 2003 11:34:11 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Walt H <waltabbyh@comcast.net>, arjanv@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       davzaffiro@tasking.nl
Subject: Re: [PATCH] pdcraid and weird IDE geometry
References: <3F160965.7060403@comcast.net>	 <1058431742.5775.0.camel@laptop.fenrus.com>  <3F16B49E.8070901@comcast.net> <1058453918.9055.12.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1058453918.9055.12.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can't you fix the geometry from fdisk expert mode?

I've done that several times before, when otherwise like-sized disks 
appeared with vastly different geometry.

