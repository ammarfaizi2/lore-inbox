Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760504AbWLFLki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760504AbWLFLki (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 06:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760505AbWLFLki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 06:40:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:58120 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760502AbWLFLkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 06:40:37 -0500
Cc: linux-kernel@vger.kernel.org, adobriyan@gmail.com,
       linux1394-devel@lists.sourceforge.net, krh@redhat.com
Content-Type: text/plain; charset="iso-8859-1"
Date: Wed, 06 Dec 2006 12:40:36 +0100
From: "Alexander Neundorf" <a.neundorf-work@gmx.net>
In-Reply-To: <457685D1.1080501@s5r6.in-berlin.de>
Message-ID: <20061206114036.130470@gmx.net>
MIME-Version: 1.0
References: <20061205052229.7213.38194.stgit@dinky.boston.redhat.com>	
	<20061205184921.GA5029@martell.zuzino.mipt.ru>		<4575FF08.2030100@redhat.com>
 <1165383349.7443.78.camel@gullible>  <457685D1.1080501@s5r6.in-berlin.de>
Subject: Re:  Re: [PATCH 0/3] New firewire stack
To: Stefan Richter <stefanr@s5r6.in-berlin.de>, ben.collins@ubuntu.com
X-Authenticated: #19207638
X-Flags: 0001
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Von: Stefan Richter <stefanr@s5r6.in-berlin.de>

...
> bugs get fixed. Mainline's FireWire stack lost a lot of trust at
> end-users and application developers because of periods of sometimes
> very visible regressions.

For us it's working well, with no major problems (there was a problem with SMP kernels and the arm mapping, but my kernel is not recent and I didn't find the time yet to update to current versions, so I could not report the bug). We have customers and it works for them.

OTOH I heard from some people who wanted to use the 1394 stack for embedded devices without PCI and they didn't succeed to add support for their selected chipset. 

Bye
Alex

-- 
Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen! 
Ideal für Modem und ISDN: http://www.gmx.net/de/go/smartsurfer
