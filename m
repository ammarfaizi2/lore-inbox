Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbTLLUDL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 15:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbTLLUDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 15:03:10 -0500
Received: from [66.35.146.201] ([66.35.146.201]:785 "EHLO int1.nea-fast.com")
	by vger.kernel.org with ESMTP id S261914AbTLLUDB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 15:03:01 -0500
Content-Type: text/plain; charset=US-ASCII
From: walt <walt@nea-fast.com>
Organization: NEA
To: Marco Roeland <marco.roeland@xs4all.nl>
Subject: Re: 2.6-test11  build error (fs/proc/array.c gcc 2.96 again!)
Date: Fri, 12 Dec 2003 15:02:58 -0500
User-Agent: KMail/1.4.3
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <200312121159.23972.walt@nea-fast.com> <20031212181314.GA23973@localhost>
In-Reply-To: <20031212181314.GA23973@localhost>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200312121502.58555.walt@nea-fast.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 December 2003 01:13 pm, Marco Roeland wrote:
> On Friday december 12th 2003 walt wrote:
> > I got the following when trying to compile 2.6.0-test11. Config is
> > attached.
> >
> > [internal compiler error for fs/proc/array.c]
>

Thanks Marco!

FYI - I removed 
Kernel .config support (IKCONFIG)
and it compiled fine.


-- 
Walter Anthony
System Administrator
National Electronic Attachment
Atlanta, Georgia 
 "If it's not broke....tweak it"


