Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289724AbSAOXPA>; Tue, 15 Jan 2002 18:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289735AbSAOXOI>; Tue, 15 Jan 2002 18:14:08 -0500
Received: from fungus.teststation.com ([212.32.186.211]:62980 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S289724AbSAOXOD>; Tue, 15 Jan 2002 18:14:03 -0500
Date: Wed, 16 Jan 2002 00:13:48 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: <puw@cola.teststation.com>
To: Patrick Mochel <mochel@osdl.org>
cc: Nicolas Pitre <nico@cam.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Why not "attach" patches?
In-Reply-To: <Pine.LNX.4.33.0201151405250.9053-100000@segfault.osdlab.org>
Message-ID: <Pine.LNX.4.33.0201160000400.1742-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jan 2002, Patrick Mochel wrote:

> It doesn't at all. It silently removes extra white space at the end of
> lines. It's been a "feature" since about 4.30 or so.

I am pretty sure that it works fine in RedHat's 4.33 version (or else
Linus would have dropped some of my patches ... er, more of my patches :).
But I haven't checked how that version differs from the original.

At the end is a simple ^R-ed file that works for me sending to myself.
But I don't think it is related to ^R ...   
(should be 3 spaces after that line)

If you postpone a message it has a silly idea to add an empty line at the
end. But that shouldn't break patches.

/Urban


no space
tab	
3 spaces   
no space

