Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288159AbSAMV7p>; Sun, 13 Jan 2002 16:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288166AbSAMV7f>; Sun, 13 Jan 2002 16:59:35 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:57239 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S288159AbSAMV73>;
	Sun, 13 Jan 2002 16:59:29 -0500
Date: Sun, 13 Jan 2002 16:59:27 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: initramfs buffer spec -- second draft
In-Reply-To: <m1elkuq87v.fsf@frodo.biederman.org>
Message-ID: <Pine.GSO.4.21.0201131656190.27390-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 13 Jan 2002, Eric W. Biederman wrote:
 
> Which we are reusing for a different purpose.  And because of that we
> become trustees of our version of the format.  To make it clear that
> someone else defines how this format works a reference to the
> appropriate specification is called for.  

We are using it for precisely the same purpose - to put a bunch of
files on a filesystem.
 
> The cases where initramfs will be used are some of the most operating
> specific cases I can imagine.  To handle those cases it is necessary
> to support the full breadth of the capability of the operating system.

Huh?  It's a bloody archive - collection of files and nothing else.
What "capability of the operating system"?

