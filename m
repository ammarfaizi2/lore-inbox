Return-Path: <linux-kernel-owner+w=401wt.eu-S1754013AbWLXBNq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754013AbWLXBNq (ORCPT <rfc822;w@1wt.eu>);
	Sat, 23 Dec 2006 20:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754039AbWLXBNq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Dec 2006 20:13:46 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:6327 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754013AbWLXBNo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Dec 2006 20:13:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=jDjS6M1g3sictXOYITN9LbLxXcHsO4je4+w9Pb9zw9cLCIQ+Fr5UeNq6i6ahKi7t9bTMCgqrYxtvqFECybSkMIuR4V91X1npzc/A78DTpt8RMelIFXobIXYu0qzW03jY1sUVIXjb5MKRURHj7/fDEWpqLZqcME2LrqQ8AgEWB5s=
Message-ID: <458DD459.2030209@gmail.com>
Date: Sun, 24 Dec 2006 02:13:38 +0059
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>,
       marcel@holtmann.org, maxk@qualcomm.com,
       bluez-devel@lists.sourceforge.net
Subject: Re: ptrace() memory corruption?
References: <20061223234305.GA1809@elf.ucw.cz> <20061223235501.GA1740@elf.ucw.cz> <20061224000150.GA1812@elf.ucw.cz> <20061224000605.GA1768@elf.ucw.cz> <20061224000753.GA1811@elf.ucw.cz>
In-Reply-To: <20061224000753.GA1811@elf.ucw.cz>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
>> Is there something wrong with gdb?
> 
> Yep. If I do gdb /bin/bash, run; I'll get similar oops. Am I alone
> seeing this?

Nope, I have this nasty thing here too and will post oopses in the afternoon,
just before Jezisek comes :).

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
