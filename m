Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264439AbTLGPtM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 10:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264441AbTLGPtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 10:49:12 -0500
Received: from mail.gmx.de ([213.165.64.20]:921 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264439AbTLGPtK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 10:49:10 -0500
X-Authenticated: #4512188
Message-ID: <3FD34BF4.1070503@gmx.de>
Date: Sun, 07 Dec 2003 16:49:08 +0100
From: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031116
X-Accept-Language: de-de, de, en-us, en
MIME-Version: 1.0
To: Jussi Laako <jussi@sonarnerd.net>
CC: Julien Oster <frodoid@frodoid.org>, linux-kernel@vger.kernel.org
Subject: Re: NForce2 pseudoscience stability testing (2.6.0-test11)
References: <200311292325.44935.csawtell@paradise.net.nz>	 <1070104685.29442.24.camel@athlonxp.bradney.info>	 <frodoid.frodo.87d6bbjfqa.fsf@usenet.frodoid.org> <1070796778.14757.2.camel@vaarlahti.uworld>
In-Reply-To: <1070796778.14757.2.camel@vaarlahti.uworld>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jussi Laako wrote:
> On Sat, 2003-11-29 at 18:34, Julien Oster wrote:
> 
> 
>>>I am also using a 2 week old A7N8X Deluxe, v2 with the latest 1007 BIOS.
>>>I AM able to run 2.6 Test 11 with APIC, Local APIC and ACPI support
>>>turned on (SMP off, Preemptible Kernel off).
>>
>>Unfortunately, I have the exact same configuration, with massive
>>lockups. Could you try executing "hdparm -t /dev/<someharddisk>"
>>several times and see if it lockups?
> 
> 
> I don't think this is Linux-related. None of the NForce2 motherboards
> with chipset revision same as the one on A7N8X Deluxe rev2 is able to
> run memtest86 for 72 hours without errors with any memory tested (about
> 20 different DIMMs). NForce2 chipset is just broken.


Have you taken a look into the other nforce2 thread? A possible 
solution/Patch has been posted.



