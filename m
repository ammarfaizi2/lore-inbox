Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262255AbSJFXXG>; Sun, 6 Oct 2002 19:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262256AbSJFXXG>; Sun, 6 Oct 2002 19:23:06 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:19238 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S262255AbSJFXXF>;
	Sun, 6 Oct 2002 19:23:05 -0400
Date: Mon, 7 Oct 2002 01:28:38 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Allan Duncan <allan.d@bigpond.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.40 etc and IDE HDisk geometry
Message-ID: <20021006232838.GA20993@win.tue.nl>
References: <3D9D9BE4.32421A87@bigpond.com> <20021004215049.GA20192@win.tue.nl> <3DA0AFBE.935D25BA@bigpond.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DA0AFBE.935D25BA@bigpond.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2002 at 07:48:46AM +1000, Allan Duncan wrote:

> Like LILO.  It complains

Maybe sufficiently recent LILO is OK.

> Maybe I should start looking at grub, assuming it doesn't do the same.

"lilo -R" is very useful. I don't think grub has that capability.

Andries
