Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289005AbSAZDSV>; Fri, 25 Jan 2002 22:18:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289003AbSAZDSL>; Fri, 25 Jan 2002 22:18:11 -0500
Received: from zero.tech9.net ([209.61.188.187]:47372 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S289005AbSAZDRy>;
	Fri, 25 Jan 2002 22:17:54 -0500
Subject: Re: [PATCH] add BUG_ON to 2.4 #1
From: Robert Love <rml@tech9.net>
To: John Levon <movement@marcelothewonderpenguin.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020126031732.GA59924@compsoc.man.ac.uk>
In-Reply-To: <1012000446.3799.77.camel@phantasy> 
	<20020126031732.GA59924@compsoc.man.ac.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 25 Jan 2002 22:22:51 -0500
Message-Id: <1012015382.3501.269.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-01-25 at 22:17, John Levon wrote:

> I mentioned earlier today we need someone to step up and write a kcompat.h
> for 2.5 stuff like minor() and the new remap_page_range().
> 
> I'll have to do this anyway for the stuff I use (I already have oodles of
> 2.2 stuff) but it would be nice to be able to use a "standard" header (and .c
> if necessary)

Hopefully Marcelo will take this patch and we won't need BUG_ON, at
least, for 2.5->2.4 compatibility.

	Robert Love

