Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289571AbSAVXiO>; Tue, 22 Jan 2002 18:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289564AbSAVXiI>; Tue, 22 Jan 2002 18:38:08 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:32787 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S289571AbSAVXhq>;
	Tue, 22 Jan 2002 18:37:46 -0500
Date: Tue, 22 Jan 2002 21:37:32 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Shawn Starr <spstarr@sh0n.net>
Cc: Linux <linux-kernel@vger.kernel.org>
Subject: Re: Possible Idea with filesystem buffering.
In-Reply-To: <1011742313.269.15.camel@unaropia>
Message-ID: <Pine.LNX.4.33L.0201222136510.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Jan 2002, Shawn Starr wrote:

> The only functionality added to the kernel would be a a interface for
> filesystems to share it would basically create kpagebuf_* functions.

What would these things achieve ?

It would be nice if you could give us a quick explanation of
what exactly kpagebufd is supposed to do, if only so I can
keep that in mind while working on the VM ;)

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

