Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291642AbSBTFIC>; Wed, 20 Feb 2002 00:08:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291645AbSBTFHx>; Wed, 20 Feb 2002 00:07:53 -0500
Received: from [194.46.8.33] ([194.46.8.33]:33811 "EHLO angusbay.vnl.com")
	by vger.kernel.org with ESMTP id <S291642AbSBTFHl>;
	Wed, 20 Feb 2002 00:07:41 -0500
Date: Wed, 20 Feb 2002 05:18:08 +0000
From: Dale Amon <amon@vnl.com>
To: Justin Piszcz <war@starband.net>
Cc: Dale Amon <amon@vnl.com>, linux-kernel@vger.kernel.org
Subject: Re: make install doesn't work for kernel factories
Message-ID: <20020220051808.GD29004@vnl.com>
Mail-Followup-To: Dale Amon <amon@vnl.com>,
	Justin Piszcz <war@starband.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20020220041413.GC29004@vnl.com> <3C73272B.9BDE55CE@starband.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C73272B.9BDE55CE@starband.net>
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux, the choice of a GNU generation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2002 at 11:33:47PM -0500, Justin Piszcz wrote:
> Have you looked at http://www.installkernel.com/ ?
> ik -i does the install.

But it doesn't seem to have an argument by which you
can tell it to install in for example:

	/somedisk/workdir/cdbuildroot/boot/

instead of:

	/boot

I've got my own equivalent of lk btw... but I don't
use it to install on the *build* machine. I'm building
for CDROM's and into directories that will be tar'd
up and scp'd to other machines that do not have
compilers installed.

-- 
------------------------------------------------------
    Nuke bin Laden:           Dale Amon, CEO/MD
  improve the global          Islandone Society
     gene pool.               www.islandone.org
------------------------------------------------------
