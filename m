Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265194AbSJaGQY>; Thu, 31 Oct 2002 01:16:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265191AbSJaGQX>; Thu, 31 Oct 2002 01:16:23 -0500
Received: from tapu.f00f.org ([66.60.186.129]:60643 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S265194AbSJaGQX>;
	Thu, 31 Oct 2002 01:16:23 -0500
Date: Wed, 30 Oct 2002 22:22:49 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: What's left over.
Message-ID: <20021031062249.GB18007@tapu.f00f.org>
References: <Pine.LNX.4.44.0210301823120.1396-100000@home.transmeta.com> <Pine.LNX.4.44L.0210310105160.1697-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0210310105160.1697-100000@imladris.surriel.com>
User-Agent: Mutt/1.4i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2002 at 01:06:54AM -0200, Rik van Riel wrote:

> Personally I do think either the unlimited groups patch or ACLs are
> needed in order to sanely run a large anoncvs setup.

Processes need to be a member of 20+ groups to make anoncvs work?
Sounds like anoncvs is broken then.


  --cw
