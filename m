Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265398AbUAFW2w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 17:28:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265399AbUAFW2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 17:28:52 -0500
Received: from [66.62.77.7] ([66.62.77.7]:43417 "EHLO mail.gurulabs.com")
	by vger.kernel.org with ESMTP id S265398AbUAFW2v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 17:28:51 -0500
Subject: Re: name spaces good (was: [autofs] [RFC] Towards a Modern Autofs)
From: Dax Kelson <dax@gurulabs.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: thockin@Sun.COM, Mike Waychison <Michael.Waychison@Sun.COM>,
       autofs mailing list <autofs@linux.kernel.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3FFB316A.6000004@zytor.com>
References: <3FFB12AD.6010000@sun.com> <3FFB223A.8000606@zytor.com>
	 <20040106215018.GA911@sun.com>  <3FFB316A.6000004@zytor.com>
Content-Type: text/plain
Message-Id: <1073428129.2454.35.camel@mentor.gurulabs.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 06 Jan 2004 15:28:49 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-01-06 at 15:06, H. Peter Anvin wrote:
> First of all, I'll be blunt: namespaces currently provide zero benefit
> in Linux, and virtually noone uses them.

I strongly disagree.

I find them very useful, and there are lots of problems that are not
cleanly solved any other way. In particular they are very useful in
security hardening, compartmentalization scenarios.

The abysmal state of Linux autofs is something that needs fixing
yesterday.

Dax Kelson

