Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269872AbUJGW4i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269872AbUJGW4i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 18:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269875AbUJGWze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 18:55:34 -0400
Received: from manson.clss.net ([65.211.158.2]:57049 "HELO manson.clss.net")
	by vger.kernel.org with SMTP id S269873AbUJGWdf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 18:33:35 -0400
Message-ID: <20041007223334.10692.qmail@manson.clss.net>
From: "Alan Curry" <pacman-kernel@manson.clss.net>
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
To: davem@davemloft.net (David S. Miller)
Date: Thu, 7 Oct 2004 17:33:33 -0500 (EST)
Cc: msipkema@sipkema-digital.com (Martijn Sipkema),
       cfriesen@nortelnetworks.com, hzhong@cisco.com, jst1@email.com,
       linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       davem@redhat.com
In-Reply-To: <20041007152400.17e8f475.davem@davemloft.net> from "David S. Miller" at Oct 07, 2004 03:24:00 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller writes the following:
>
>I can't believe this thread has lasted this long.  I think people
>had cotton in their ears when I mentioned that every single 2.4.x
>and 2.6.x existing system out there has this behavior, therefore
>even if we changed the behavior some way today people still need
>to handle this to work on all existing Linux systems.

That argument sounds like "I broke something a few years ago, and nobody
complained quickly enough, so I got away with it." It's not impressive.

