Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbTIZP5N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 11:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261675AbTIZP5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 11:57:13 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:53704 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261464AbTIZP5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 11:57:12 -0400
Date: Fri, 26 Sep 2003 17:56:54 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: John Cherry <cherry@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IA32 - 6 New warnings (gcc 3.2.2)
Message-ID: <20030926155654.GO15696@fs.tum.de>
References: <200309260548.h8Q5mZt3015714@cherrypit.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309260548.h8Q5mZt3015714@cherrypit.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 25, 2003 at 10:48:35PM -0700, John Cherry wrote:
>...
> drivers/char/drm/sis_mm.c:92: warning: unused variable `req'
>...

Looking at the code, this seems to be a bogus warning in the gcc version
you are using.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

