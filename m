Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbUDNTkF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 15:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbUDNTkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 15:40:05 -0400
Received: from mail.shareable.org ([81.29.64.88]:47009 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261375AbUDNTkD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 15:40:03 -0400
Date: Wed, 14 Apr 2004 20:39:47 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Dirk Morris <dmorris@metavize.com>
Cc: Davide Libenzi <davidel@xmailserver.org>, Ben Mansell <ben@zeus.com>,
       Steven Dake <sdake@mvista.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: epoll reporting events when it hasn't been asked to
Message-ID: <20040414193947.GE12105@mail.shareable.org>
References: <Pine.LNX.4.44.0404020717350.1828-100000@bigblue.dev.mdolabs.com> <407D7BFF.4010700@metavize.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <407D7BFF.4010700@metavize.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dirk Morris wrote:
> I need them to be handled like normal events. (I can explain more off 
> list if you'd like)

Did you read my explanation of how to do this using the present epoll
behaviour using _fewer_ syscalls than you are asking for?

-- Jamie
