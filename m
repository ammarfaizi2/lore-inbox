Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262974AbUDZP6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262974AbUDZP6h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 11:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263019AbUDZP6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 11:58:35 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:37518 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262974AbUDZP6V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 11:58:21 -0400
Message-ID: <408D31DC.6040708@tmr.com>
Date: Mon, 26 Apr 2004 11:59:24 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
Newsgroups: mail.linux-kernel
To: Anton Altaparmakov <aia21@cam.ac.uk>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH-2.6.6-rc2-bk] NTFS 2.1.7 release: Implement NFS exporting
References: <Pine.SOL.4.58.0404232055210.15465@orange.csi.cam.ac.uk>
In-Reply-To: <Pine.SOL.4.58.0404232055210.15465@orange.csi.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:
> Linus, please do a
> 
> 	bk pull http://linux-ntfs.bkbits.net/ntfs-2.6
> 
> Thanks!  This update implements NFS exporting of mounted NTFS volumes
> which people have been requesting for a while.  Also, there are some minor
> updates and white space cleanups.  This has been tested including forcing
> a server reboot while clients have open files on an NTFS volume NFS
> exported by the server.

Sounds like tha answer to the maiden's prayer. And if it will allow both 
  NFS and SMB access to the same data, I know some people who will find 
it most useful.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
