Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262138AbUDWQkQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbUDWQkQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 12:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264865AbUDWQkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 12:40:16 -0400
Received: from mail.gmx.de ([213.165.64.20]:7903 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262138AbUDWQkM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 12:40:12 -0400
Date: Fri, 23 Apr 2004 18:40:11 +0200 (MEST)
From: Daniel.Kirsten@gmx.net
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: Re: xconfig font problems
X-Priority: 3 (Normal)
X-Authenticated: #14521599
Message-ID: <24811.1082738411@www55.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> since somewhen in the 2.6.5-rc series, I have some font problems
>> in make xconfig. I just see rectangles instead of letters...
>> However, numbers are displayed correctly. (I use Fedora.)
>>
>> Does anyone know a solution.
>
>Someone I know who had the same problem removed the .fonts.cache-1 file and
>the .qt directory from their home directory, and it fixed it. I'm guessing
>it was just the font cache file that needed to go though...

I removed .fonts.cache-1 and the .qt directory in /root and in my home 
directory. I also removed .gconf, .gconfd and every .fonts.cache-1 
file on the entire hard drive, but the problem remains (even after 
rebooting). 

Best regards, Daniel
 

-- 
"Sie haben neue Mails!" - Die GMX Toolbar informiert Sie beim Surfen!
Jetzt aktivieren unter http://www.gmx.net/info

