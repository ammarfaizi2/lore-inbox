Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271197AbTHRDI7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 23:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271201AbTHRDI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 23:08:59 -0400
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:26117 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id S271197AbTHRDI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 23:08:57 -0400
Date: Sun, 17 Aug 2003 23:59:28 -0300
From: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
To: Richard Russon <ntfs@flatcap.org>
Cc: aia21@cus.cam.ac.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix all warning deprecated in NTFS 1.1.22 (2.4)
Message-Id: <20030817235928.759adbb0.vmlinuz386@yahoo.com.ar>
In-Reply-To: <1061152213.1114.42.camel@ipa.flatcap.org>
References: <20030814035719.6905b4fd.vmlinuz386@yahoo.com.ar>
	<1061152213.1114.42.camel@ipa.flatcap.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i486-slackware-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Aug 2003 21:30:13 +0100, Richard Russon wrote:
>Hi djgera,
>
>Anton isn't ignoring you, he's just extremely busy.
>

no problem, he I answer myself Marcelo and my, accepting the patch.

>> total 191 warnings fixed!!! (it took enough hours to me)
>
>Wow, thank you very much.  You've done an amazing job.
>

:) it was a pleasure.

>I've read through the patch (yawn) and tested it.  I found a couple of
>problems (debug only), but they weren't your fault.  Several of the
>ntfs_debug's had the wrong arguments.  I've rebuilt the patch and put
>it here:
>
>  http://flatcap.org/ntfs/fix.warning.deprecated.ntfs.patch2
>  http://flatcap.org/ntfs/fix.warning.deprecated.ntfs.patch2.bz2
>
>> Please review, and confirm to Marcelo Tosatti
>

yup, by the way it forgets to me to comment to them of the lack of
arguments in original code (sorry), and thanks to correct
them.

>Now we just need to keep poking Anton :-)
>
>Thanks for your hard work.
>

excelent!

my patch is at the moment in the tree of Alan, since -ac3.


Best Regards,
 djgera


-- 
Gerardo Exequiel Pozzi ( djgera )
http://www.vmlinuz.com.ar http://www.djgera.com.ar
KeyID: 0x1B8C330D
Key fingerprint = 0CAA D5D4 CD85 4434 A219  76ED 39AB 221B 1B8C 330D
