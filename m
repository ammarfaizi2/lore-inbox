Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264409AbTLGLdk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 06:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264410AbTLGLdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 06:33:40 -0500
Received: from dsl-hkigw3l52.dial.inet.fi ([80.222.43.82]:22655 "EHLO
	uworld.dyndns.org") by vger.kernel.org with ESMTP id S264409AbTLGLdj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 06:33:39 -0500
Subject: Re: NForce2 pseudoscience stability testing (2.6.0-test11)
From: Jussi Laako <jussi@sonarnerd.net>
To: Julien Oster <frodoid@frodoid.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <frodoid.frodo.87d6bbjfqa.fsf@usenet.frodoid.org>
References: <200311292325.44935.csawtell@paradise.net.nz>
	 <1070104685.29442.24.camel@athlonxp.bradney.info>
	 <frodoid.frodo.87d6bbjfqa.fsf@usenet.frodoid.org>
Content-Type: text/plain
Organization: 
Message-Id: <1070796778.14757.2.camel@vaarlahti.uworld>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 Dec 2003 13:32:58 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-11-29 at 18:34, Julien Oster wrote:

> > I am also using a 2 week old A7N8X Deluxe, v2 with the latest 1007 BIOS.
> > I AM able to run 2.6 Test 11 with APIC, Local APIC and ACPI support
> > turned on (SMP off, Preemptible Kernel off).
> 
> Unfortunately, I have the exact same configuration, with massive
> lockups. Could you try executing "hdparm -t /dev/<someharddisk>"
> several times and see if it lockups?

I don't think this is Linux-related. None of the NForce2 motherboards
with chipset revision same as the one on A7N8X Deluxe rev2 is able to
run memtest86 for 72 hours without errors with any memory tested (about
20 different DIMMs). NForce2 chipset is just broken.


-- 
Jussi Laako <jussi@sonarnerd.net>

