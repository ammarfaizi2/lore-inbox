Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136602AbREAJiX>; Tue, 1 May 2001 05:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136603AbREAJiN>; Tue, 1 May 2001 05:38:13 -0400
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:11396 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S136602AbREAJiB>; Tue, 1 May 2001 05:38:01 -0400
Date: Tue, 1 May 2001 11:37:58 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Jeff Dike <jdike@karaya.com>
Cc: Paul J Albrecht <pjalbrecht@home.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Debuggers, KDB or KGDB?
Message-ID: <20010501113758.D3305@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <01043016264000.00697@CB57534-A> <200105010011.TAA04345@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <200105010011.TAA04345@ccure.karaya.com>; from jdike@karaya.com on Mon, Apr 30, 2001 at 07:11:35PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2001 at 07:11:35PM -0500, Jeff Dike wrote:
> pjalbrecht@home.com said:
> > Where can I find an analysis of the relative strengths and weaknesses
> > of KDB and KGDB for kernel debug? Has the linux community come to any
> > consensus regarding the utility one or the other? 
> 
> You ought to add UML to the list, since it is useful for
> debugging any part of the kernel that's not arch code or a
> hardware device driver (except that there's now USB support for
> UML).

Basically you could add support for ALL generic subsystems, that
support dummy hardware, like SCSI and ISDN for example.

Is that planned or do I suggest sth. stupid here? ;-)

Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<     been there and had much fun   >>>>>>>>>>>>
