Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261360AbSJIHcM>; Wed, 9 Oct 2002 03:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261397AbSJIHcM>; Wed, 9 Oct 2002 03:32:12 -0400
Received: from [195.20.32.236] ([195.20.32.236]:9112 "HELO euro.verza.com")
	by vger.kernel.org with SMTP id <S261360AbSJIHcL>;
	Wed, 9 Oct 2002 03:32:11 -0400
Date: Wed, 9 Oct 2002 09:37:25 +0200
From: Alexander Kellett <lypanov@kde.org>
To: jw schultz <jw@pegasys.ws>, linux-kernel@vger.kernel.org
Subject: Re: The end of embedded Linux?
Message-ID: <20021009073725.GA22778@groucho.verza.com>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <3DA1CF36.19659.13D4209@localhost> <3DA2BD70.14919.2C6951@localhost> <20021008112719.GC6537@pegasys.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021008112719.GC6537@pegasys.ws>
User-Agent: Mutt/1.4i
X-Disclaimer: My opinions do not necessarily represent those of my employer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2002 at 04:27:19AM -0700, jw schultz wrote:
<mid-sentence snip>
> You might look into something like using the adeos 
> nano-kernel to host linux and the device controll 
> software as seperate contexts with a communications 
> interface between them. 
<snip>

This talk of adeos reminds me of something that i'd
"dreamed" of a while back. Whats the feasability of
having a 70kb kernel that barely even provides support 
for user space apps and is basically just an hardware 
abstraction layer for "applications" that can be 
written as kernel modules?

mvg,
Alex
