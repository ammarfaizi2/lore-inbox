Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129144AbRBDP0f>; Sun, 4 Feb 2001 10:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129191AbRBDP0Z>; Sun, 4 Feb 2001 10:26:25 -0500
Received: from mercury.nildram.co.uk ([195.112.4.37]:9999 "EHLO
	mercury.nildram.co.uk") by vger.kernel.org with ESMTP
	id <S129144AbRBDP0Q>; Sun, 4 Feb 2001 10:26:16 -0500
Message-ID: <3A7D748C.6080701@magenta-logic.com>
Date: Sun, 04 Feb 2001 15:26:04 +0000
From: Tony Hoyle <tmh@magenta-logic.com>
Organization: Magenta Logic
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.1 i686; en-US; m18) Gecko/20010126
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ACPI broken in 2.4.1
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In my wifes' machine 2.4.1 (both vanilla and -ac2) enabling ACPI causes 
the machine to run so slowly it's unusable.  On my machine it's OK. 
2.4.0 worked fine, so something has changed between 2.4.0 and 2.4.1 that 
broke it.  I couldn't find anything in dmesg that looked any different, 
though.  However since that machine has never successfully booted with 
ACPI on the kern.log hasn't been written so it's unlikely I'd find anything.

Tony

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
