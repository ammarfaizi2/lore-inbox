Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264935AbTF0X20 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 19:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264939AbTF0X2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 19:28:25 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:7848 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S264935AbTF0X2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 19:28:23 -0400
Date: Fri, 27 Jun 2003 18:30:24 -0400
From: Ben Collins <bcollins@debian.org>
To: Andrew Morton <akpm@digeo.com>
Cc: davidel@xmailserver.org, davem@redhat.com, mbligh@aracnet.com,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: networking bugs and bugme.osdl.org
Message-ID: <20030627223024.GT501@phunnypharm.org>
References: <20030626.224739.88478624.davem@redhat.com> <21740000.1056724453@[10.10.2.4]> <Pine.LNX.4.55.0306270749020.4137@bigblue.dev.mcafeelabs.com> <20030627.143738.41641928.davem@redhat.com> <Pine.LNX.4.55.0306271454490.4457@bigblue.dev.mcafeelabs.com> <20030627213153.GR501@phunnypharm.org> <20030627162527.714091ce.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030627162527.714091ce.akpm@digeo.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> - The bugs which are affecting people the most get reported the most.

Not to mention the "breeding" affect. A bug that many people have seen
only once, but can never pinpoint because they can't reproduce it. One
of those people reports the problem to the mailing list, and suddenly
half a dozen respond with "me too, but here's some extra info that I
saw". You can't get that with a bug database.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
