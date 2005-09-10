Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbVIJNO6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbVIJNO6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 09:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbVIJNO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 09:14:58 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:22144 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP
	id S1750815AbVIJNO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 09:14:58 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [2.6-GIT] NTFS: Release 2.1.24.
Date: Sat, 10 Sep 2005 14:15:11 +0100
User-Agent: KMail/1.8.90
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
References: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk>
In-Reply-To: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509101415.12039.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 09 September 2005 10:18, Anton Altaparmakov wrote:
> Hi Linus, please pull from
>
> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/aia21/ntfs-2.6.git/HEAD
>
> This is the next NTFS update containing a ton of bug fixes several of
> which fix bugs people actually hit in the big bad world...
>
> Please apply.  Thanks!
>
> I am sending the changesets as actual patches generated using git
> format-patch for non-git users in follow up emails (in reply to this one).
>

Anton,

Do these changes allow us to mount an NTFS volume created by Windows 
Vista/Longhorn beta 1 yet? I tried the driver in 2.6.13, and it complains 
about these $LogFile states, and ntfscp refuses to work.

If you're unaware of the problem, I'm happy to help debug it.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
