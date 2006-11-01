Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992707AbWKAS3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992707AbWKAS3J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 13:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992708AbWKAS3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 13:29:09 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:37349 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S2992707AbWKAS3H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 13:29:07 -0500
Message-ID: <4548E76B.4020500@gmail.com>
Date: Wed, 01 Nov 2006 19:28:59 +0100
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
CC: Jiri Slaby <jirislaby@gmail.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: preferred way of fw loading
References: <4547E720.4080505@gmail.com> <20061101072957.GA14955@bitwizard.nl>
In-Reply-To: <20061101072957.GA14955@bitwizard.nl>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: jirislaby@gmail.com
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rogier Wolff wrote:
> On Wed, Nov 01, 2006 at 01:15:28AM +0100, Jiri Slaby wrote:
>> For char sx driver in this case (I hope there is no later fw):
>> ftp://ftp.bitwizard.nl/specialix/sx_firmware_306c.tgz
> 
>> Now it's 2 .c files used by loader through ioctl. After compilation it has:
>>    text    data     bss     dec     hex filename
>>       4    8416       2    8422    20e6 si2_z280.o
>>       4   19484       2   19490    4c22 si3_t225.o
> 
> I see two different processors, there are three.

And don't you know, where may one obtain some later release? I found only this
package which includes only these two.

thanks,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
