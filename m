Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265251AbTLZXCg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 18:02:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265250AbTLZXCf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 18:02:35 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:2528 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S265251AbTLZXCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 18:02:32 -0500
Date: Fri, 26 Dec 2003 15:02:30 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Sander Sweers <sandersweers@xs4all.nl>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0 sound output - wierd effects
Message-ID: <1790000.1072479749@[10.10.2.4]>
In-Reply-To: <3FECBD42.7000500@xs4all.nl>
References: <1080000.1072475704@[10.10.2.4]> <3FECBD42.7000500@xs4all.nl>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Anyone else seen this, or got any clues? Else I guess I'm stuck playing
>> bisection search.
> 
> Yes had this problem, i found that it was the oss emulation. When i
> switched to the alsa plugin the effect was gone.

Cool, thanks ... but it used to work this way. 2.5.70 worked ... if you're
seeing the same problem on 2.6.0, any chance you could confirm that 2.5.70
works for you?

M.

