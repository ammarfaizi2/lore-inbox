Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265641AbUAMVO4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 16:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265649AbUAMVO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 16:14:56 -0500
Received: from [65.248.109.87] ([65.248.109.87]:12749 "EHLO
	ns1.brianandsara.net") by vger.kernel.org with ESMTP
	id S265641AbUAMVOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 16:14:51 -0500
From: Brian Jackson <iggy@gentoo.org>
Organization: Gentoo Linux
To: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: athlon-xp header issue
Date: Tue, 13 Jan 2004 15:14:58 -0600
User-Agent: KMail/1.5.94
References: <398633829.20040113113000@netdork.net> <20040113191217.GA29400@redhat.com>
In-Reply-To: <20040113191217.GA29400@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200401131514.58205.iggy@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 January 2004 01:12 pm, Dave Jones wrote:
> On Tue, Jan 13, 2004 at 11:30:00AM -0600, Jonathan Angliss wrote:
>  > This gave me a hint. So I took a look in arch/i386/config.in and
>  > noticed that the check for CONFIG_MK7XP is missing. This results in
>  > the appropriate settings not being set. Is this intentional? Or am I
>  > looking in the wrong area for my problem?
>
> CONFIG_MK7XP is a gentoo specific bogon. Bug them about it.
> (For info on why its bogus, search the linux-kernel archives,
>  as it comes up every few months.)

Are you referring to the fact that Gentoo's kernel is a steamy pile, or the 
fact that the extra athlon-xp stuff is pointless?

--Iggy

>
> 		Dave
>
