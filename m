Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263970AbTEJKoM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 06:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263983AbTEJKoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 06:44:12 -0400
Received: from gw.mh.interware.hu ([195.70.49.222]:11274 "EHLO gw.home")
	by vger.kernel.org with ESMTP id S263970AbTEJKoM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 06:44:12 -0400
Subject: Re: 2.5.69: VIA IDE still broken
From: Hirling Endre <endre@interware.hu>
To: Felix von Leitner <felix-kernel@fefe.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030508220910.GA1070@codeblau.de>
References: <20030508220910.GA1070@codeblau.de>
Content-Type: text/plain
Organization: 
Message-Id: <1052564202.873.9.camel@bent.home>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 10 May 2003 12:56:42 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-05-09 at 00:09, Felix von Leitner wrote:

> that.  Even the CPU appears to run too hot with Linux, causing the
> system to boot spontaneously under load, and because ACPI is terminally
> broken in Linux and has been every time I tried it, I can't do much
> about it.  Firewire does not like me (modprobe eth1394 -> oops), IDE
> loses interrupts (see above), my USB mouse stops working as soon as I
> plug in my USB hard disk (which works fine on my notebook and under
> Windows), using my IDE CD-R causes the machine to freeze while cdrecord
> does OTP, finalizing or eject.  The nvidia graphics card takes major

These sound like you have a weak power supply, try putting in a bigger
one and see if it cures the problems.

-m-

