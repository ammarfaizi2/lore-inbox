Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265596AbTF2K1G (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 06:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265622AbTF2K1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 06:27:06 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:31628
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S265596AbTF2K1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 06:27:04 -0400
Subject: Re: Linux 2.4.22-pre2 and AthlonMP?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Willy TARREAU <willy@w.ods.org>
Cc: Edward Tandi <ed@efix.biz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030629074542.GA207@pcw.home.local>
References: <1056833424.30265.39.camel@wires.home.biz>
	 <1056837060.6778.2.camel@dhcp22.swansea.linux.org.uk>
	 <1056840603.30264.45.camel@wires.home.biz>
	 <1056842271.6753.19.camel@dhcp22.swansea.linux.org.uk>
	 <1056845040.2315.27.camel@wires.home.biz>
	 <1056848334.2332.6.camel@wires.home.biz>
	 <20030629074542.GA207@pcw.home.local>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1056883110.16255.4.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 29 Jun 2003 11:38:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-06-29 at 08:45, Willy TARREAU wrote:
> ===> To conclude, I would say don't worry about the model name, since
>      the BIOS seems to have the ability to change it to whatever it thinks
>      is appropriate (I would laugh to see a 'GenuineIntel' here :-)). But

You can twiddle the model data if you have the right (NDA) docs, and yes
some old BIOSen get it wrong.


