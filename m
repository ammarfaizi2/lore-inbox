Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262913AbTLOBkX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 20:40:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262914AbTLOBkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 20:40:23 -0500
Received: from smtp-out3.blueyonder.co.uk ([195.188.213.6]:28609 "EHLO
	smtp-out3.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S262913AbTLOBkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 20:40:22 -0500
Message-ID: <3FDD1104.8050707@blueyonder.co.uk>
Date: Mon, 15 Dec 2003 01:40:20 +0000
From: Sid Boyce <sboyce@blueyonder.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: No VT console on 2.6.0-test11
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Dec 2003 01:40:31.0219 (UTC) FILETIME=[6CCF3C30:01C3C2AC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frederik Deweerdt wrote:
 >vga=normal in order to see the bootup messages, looks like a FB bug.
 >Not sure its a bug, I though that the vga= interface may just have
 >changed. You may want to have a look at Documenation/svga.txt, but in
 >short, vga=ask and then vga=<mode # you've choosen> should suffice.
 >Regards,
 >Fred
The vga=0x31a used by the 2.4 kernels is the one I've been trying, I 
think I shall try vga=scan and see if I can find one that works for 
2.6.0-test11.
Thanks & Regards
Sid.
-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
Linux Only Shop.
