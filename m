Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262168AbSJNUSL>; Mon, 14 Oct 2002 16:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262169AbSJNUSL>; Mon, 14 Oct 2002 16:18:11 -0400
Received: from tapu.f00f.org ([66.60.186.129]:47522 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S262168AbSJNUSK>;
	Mon, 14 Oct 2002 16:18:10 -0400
Date: Mon, 14 Oct 2002 13:24:04 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Daniele Lugli <genlogic@inrete.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: unhappy with current.h
Message-ID: <20021014202404.GA10777@tapu.f00f.org>
References: <3DAB1F00.667B82B5@inrete.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DAB1F00.667B82B5@inrete.it>
User-Agent: Mutt/1.4i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2002 at 09:46:08PM +0200, Daniele Lugli wrote:

> I recently wrote a kernel module which gave me some mysterious
> problems. After too many days spent in blood, sweat and tears, I found the cause:

> *** one of my data structures has a field named 'current'. ***

gcc -Wshadow



  --cw
