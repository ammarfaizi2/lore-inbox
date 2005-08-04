Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262216AbVHDIZI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262216AbVHDIZI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 04:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262219AbVHDIZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 04:25:08 -0400
Received: from viking.sophos.com ([194.203.134.132]:51211 "EHLO
	viking.sophos.com") by vger.kernel.org with ESMTP id S262216AbVHDIZF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 04:25:05 -0400
MIME-Version: 1.0
X-MIMETrack: S/MIME Sign by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 5.0.12
  |February 13, 2003) at 04/08/2005 09:24:57,
	Serialize by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 5.0.12  |February
 13, 2003) at 04/08/2005 09:24:57,
	Serialize complete at 04/08/2005 09:24:57,
	S/MIME Sign failed at 04/08/2005 09:24:57: The cryptographic key was not
 found,
	S/MIME Sign by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 5.0.12
  |February 13, 2003) at 04/08/2005 09:25:01,
	Serialize by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 5.0.12  |February
 13, 2003) at 04/08/2005 09:25:01,
	Serialize complete at 04/08/2005 09:25:01,
	S/MIME Sign failed at 04/08/2005 09:25:01: The cryptographic key was not
 found,
	Serialize by Router on Mercury/Servers/Sophos(Release 6.5.2|June 01, 2004) at
 04/08/2005 09:25:04,
	Serialize complete at 04/08/2005 09:25:04
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, samba@samba.org
Subject: Re: Is anyone maintaining the smb filesystem?
X-Mailer: Lotus Notes Release 5.0.12   February 13, 2003
Message-ID: <OFF8C2E0A3.E0EC1DCE-ON80257053.002D9CAB-80257053.002E3C62@sophos.com>
From: tvrtko.ursulin@sophos.com
Date: Thu, 4 Aug 2005 09:25:01 +0100
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/2005 17:03:04 linux-kernel-owner wrote:

>Is anyone maintaining the smb filesystem in the Linux kernel?

It probably won't help you much, but I had the same problem few months 
ago. There was a bug in smbfs which I tried to discuss with someone, and 
after failing to contact the maintainer, I sent the fix to Linus. I don't 
think even he managed to get a response from Urban or someone else. The 
fix went in so I stopped chasing it.

So it looks like smbfs is not maintained.


