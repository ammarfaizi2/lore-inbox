Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264653AbTFYQpb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 12:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264655AbTFYQpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 12:45:31 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:13063 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264653AbTFYQpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 12:45:30 -0400
Date: Wed, 25 Jun 2003 17:59:39 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Jaakko Niemi <liiwi@lonesom.pp.fi>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5 and neomagic framebuffer problem
In-Reply-To: <87n0g6ryh4.fsf@jumper.lonesom.pp.fi>
Message-ID: <Pine.LNX.4.44.0306251758220.26713-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>  With 2.5 and neomagic framebuffer on my thinkpad 570e, if

I have this chipset and I see the same bugs. I believe it is a bug in the 
copyarea code. I plan to fix it very soon. Especially since I plan to add 
hardware cursor and edid support to this driver soon.


