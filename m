Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263866AbTDVUn5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 16:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263867AbTDVUn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 16:43:57 -0400
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:12043 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263866AbTDVUnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 16:43:52 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: "Dave Mehler" <dmehler26@woh.rr.com>
Subject: Re: 2.5 kernel hangs system
Date: Tue, 22 Apr 2003 22:55:21 +0200
User-Agent: KMail/1.5
References: <000501c3090c$71683c60$0200a8c0@satellite>
In-Reply-To: <000501c3090c$71683c60$0200a8c0@satellite>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304222255.21897.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 April 2003 22:19, Dave Mehler wrote:
>     Ok, i've got a 2.5.68 kernel compilation that when i try to boot it it
> hangs the system. It gives me hex codes after it loads the kernel or if i
> have it load an initrd, it loads that then gives hex codes and stops.
>     I've got output from lspci -v and my config file at the following url:
> www.davemehler.net
>     Suggestions are desperately needed.
> If there's missing information that i should post please let me know and i
> will post it.

please post all messages (The "hex-codes").
You may need to read
Documentation/serial-console.txt
Documentation/oops-tracing.txt
if you don't know how to catch them.

-- 
Regards Michael Buesch.
http://www.8ung.at/tuxsoft

$ cat /dev/zero > /dev/null
/dev/null: That's *not* funny! :(

