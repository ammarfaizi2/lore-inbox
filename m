Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264337AbUE3UnO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264337AbUE3UnO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 16:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264358AbUE3UnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 16:43:14 -0400
Received: from bezsensu.pl ([62.121.111.178]:43667 "EHLO laptok.bezsensu.pl")
	by vger.kernel.org with ESMTP id S264337AbUE3UnM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 16:43:12 -0400
From: Pawel Kot <pkot@bezsensu.pl>
To: Martin Olsson <mnemo@minimum.se>
Subject: Re: Why is proper NTFS-driver difficult?
Date: Sun, 30 May 2004 22:33:54 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
References: <40BA1FD5.9080902@minimum.se>
In-Reply-To: <40BA1FD5.9080902@minimum.se>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405302233.55108.pkot@bezsensu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 30 May 2004 19:54, Martin Olsson wrote:

Hi Martin,

> I was wondering why is there no Linux NTFS-driver which allows full
> writing etc? Is there something that makes this particular difficult to
> implement? I mean Linux supports so many file systems, why has proper
> NTFS support been neglected?

Because it is not easy. NTFS has very sophisticated structure, not documented 
anywhere but already reverse engineered and partially documented at 
linux-ntfs project page (http://linux-ntfs.sf.net/).

As I said this is not easy task and as such it is time consuming. All 
linux-ntfs developers are volunteers and not paid for this work. It means 
that all code is written in the free time. Much time was also spent on 
helping users (this will change now, see the manifest on the project page).

To summarize, the write support will appear sooner or later, if you volunteer 
to help, you are very welcome.

I'm ccing ntfs-dev list which is a better place to discuss such topics.

take care,
pkot
-- 
mailto:pkot@bezsensu.pl
http://www.gnokii.org/
