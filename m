Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264688AbSLTSb6>; Fri, 20 Dec 2002 13:31:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264729AbSLTSb5>; Fri, 20 Dec 2002 13:31:57 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:12037 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S264688AbSLTSb4>; Fri, 20 Dec 2002 13:31:56 -0500
Date: Fri, 20 Dec 2002 18:39:59 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Pavel Machek <pavel@ucw.cz>
cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.52 vesafb -- no display
In-Reply-To: <20021218220119.GA118@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0212201839190.6471-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> vesafb still shows nothing on HP OmniBook. It worked in 2.5.49, IIRC,
> and works on Toshiba.

Let me guess. You are using vga=791. Try changing that to another mode. 

