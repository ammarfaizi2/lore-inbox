Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751423AbWFBOHZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbWFBOHZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 10:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751429AbWFBOHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 10:07:25 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:56227 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1751423AbWFBOHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 10:07:22 -0400
Date: Fri, 2 Jun 2006 11:07:24 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Pete Zaitcev <zaitcev@redhat.com>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH RFC 0/11] usbserial: Serial Core port.
Message-ID: <20060602110724.132b9235@doriath.conectiva>
In-Reply-To: <1149256446.5053.40.camel@pmac.infradead.org>
References: <1149217397133-git-send-email-lcapitulino@mandriva.com.br>
	<20060601234833.adf12249.zaitcev@redhat.com>
	<1149242609.4695.0.camel@pmac.infradead.org>
	<20060602104542.061a1842@doriath.conectiva>
	<1149256446.5053.40.camel@pmac.infradead.org>
Organization: Mandriva
X-Mailer: Sylpheed-Claws 2.2.0 (GTK+ 2.8.17; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 02 Jun 2006 14:54:06 +0100
David Woodhouse <dwmw2@infradead.org> wrote:

| On Fri, 2006-06-02 at 10:45 -0300, Luiz Fernando N. Capitulino wrote:
| >  Unfortunally my cables only connects devices to the computers
| > (ie, I can't connect two computers).
| > 
| >  Don't know if exists a Prolific USB <-> DB9, but if it does, would
| > be good if someone could make the test. Seems easy to do. 
| 
| What manner of device does it connect? I'm sure I've seen GSM phones
| which seem to be something like pl2302 when you connect to them with
| USB... and with a phone, you can dial up to a remote system and use
| xmodem.

 Oh, got it now. Yes, it's a GSM cell phone.

 Now I'm looking for a modem to dial for, but it will be easy to get.

| You also get to test the flow control, since if you're using a 9600 baud
| dialup connection and your 'serial' link is faster than that, it'll need
| to be throttled.

 Okay.

 Thanks a lot for the suggestions.

-- 
Luiz Fernando N. Capitulino
