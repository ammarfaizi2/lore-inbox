Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266896AbTGKVvJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 17:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266885AbTGKVtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 17:49:08 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:59064
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S266899AbTGKVsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 17:48:06 -0400
Subject: Re: 2.5 'what to expect'
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Shawn <core@enodev.com>
Cc: Brian Gerst <bgerst@didntduck.org>, Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1057958368.19648.9.camel@localhost>
References: <20030711140219.GB16433@suse.de>
	 <1057933578.20636.17.camel@dhcp22.swansea.linux.org.uk>
	 <3F0F23CF.6010406@didntduck.org>  <1057958368.19648.9.camel@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1057960809.20637.58.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 11 Jul 2003 23:00:09 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-07-11 at 22:19, Shawn wrote:
> Or just run gentoo... ;) (sorry Alan)

The irony is that it seems to be because gentoo is too out of date to have
O_DIRECT enabled for the db4 library - which is where the problem is
being triggered 8)

