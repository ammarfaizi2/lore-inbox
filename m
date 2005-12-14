Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964937AbVLNUZf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964937AbVLNUZf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 15:25:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964941AbVLNUZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 15:25:34 -0500
Received: from ns2.lanforge.com ([66.165.47.211]:60052 "EHLO ns2.lanforge.com")
	by vger.kernel.org with ESMTP id S964937AbVLNUZe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 15:25:34 -0500
Message-ID: <43A07FB5.6040208@candelatech.com>
Date: Wed, 14 Dec 2005 12:25:25 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: Sridhar Samudrala <sri@us.ibm.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [RFC][PATCH 0/3] TCP/IP Critical socket communication mechanism
References: <Pine.LNX.4.58.0512140042280.31720@w-sridhar.beaverton.ibm.com> <9a8748490512141216x7e25ca2cucb675f11f0c9d913@mail.gmail.com>
In-Reply-To: <9a8748490512141216x7e25ca2cucb675f11f0c9d913@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:

> To be a little serious, it sounds like something that could be used to
> cause trouble and something that will lose its usefulness once enough
> people start using it (for valid or invalid reasons), so what's the
> point...

It could easily be a user-configurable option in an application.  If
DOS is a real concern, only let this work for root users...

Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

