Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266096AbUALJ7g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 04:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266097AbUALJ7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 04:59:36 -0500
Received: from kluizenaar.xs4all.nl ([213.84.184.247]:55113 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S266096AbUALJ7f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 04:59:35 -0500
Message-ID: <40026FEC.4040707@samwel.tk>
Date: Mon, 12 Jan 2004 10:59:08 +0100
From: Bart Samwel <bart@samwel.tk>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan De Luyck <lkml@kcore.org>, Dax Kelson <dax@gurulabs.com>
CC: linux-kernel@vger.kernel.org, Kiko Piris <kernel@pirispons.net>,
       Bartek Kania <mrbk@gnarf.org>, Simon Mackinlay <smackinlay@mail.com>
Subject: Re: [PATCH] Laptop-mode v7 for linux 2.6.1
References: <3FFFD61C.7070706@samwel.tk> <200401121045.56749.lkml@kcore.org>
In-Reply-To: <200401121045.56749.lkml@kcore.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan De Luyck wrote:
> There seems to be a typo in the battery.sh script. It 
> reads /proc/acpi/ac_adapter/AC/state to determine the AC Adaptor state, but 
> this is in the ACAD directory instead of the AC directory.

Hmmm, Dax says it works for him, and I don't have an ac_adapter on my 
machine because I don't own a laptop. Dax, is this a typo or is it 
actually called AC on your machine?

-- Bart
