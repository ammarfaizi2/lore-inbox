Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262132AbULCJu7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262132AbULCJu7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 04:50:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbULCJu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 04:50:59 -0500
Received: from host-3.tebibyte16-2.demon.nl ([82.161.9.107]:10757 "EHLO
	doc.tebibyte.org") by vger.kernel.org with ESMTP id S262132AbULCJua
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 04:50:30 -0500
Message-ID: <41B036DB.5060502@tebibyte.org>
Date: Fri, 03 Dec 2004 10:50:19 +0100
From: Chris Ross <chris@tebibyte.org>
Organization: At home (Eindhoven, The Netherlands)
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: pt-br, pt
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: oom goodness Re: 2.6.10-rc2-mm4
References: <20041130095045.090de5ea.akpm@osdl.org>
In-Reply-To: <20041130095045.090de5ea.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew Morton escreveu:
> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc2/2.6.10-rc2-mm4/

I hope I'm not tempting providence by reporting that this is the first 
unpatched kernel in a while that seems free of the oom killer problems 
I've been seeing. It's successfully handled all the usual trouble spots 
(compiling umlsim, cron.daily etc.) on my 64MB machine without killing 
off a single random process.

Regards,
Chris R.
