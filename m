Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265748AbSJTDD1>; Sat, 19 Oct 2002 23:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265749AbSJTDD0>; Sat, 19 Oct 2002 23:03:26 -0400
Received: from c-24-118-232-93.mn.client2.attbi.com ([24.118.232.93]:61831
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id <S265748AbSJTDDZ>; Sat, 19 Oct 2002 23:03:25 -0400
Date: Sat, 19 Oct 2002 22:08:36 -0500 (CDT)
From: "Scott M. Hoffman" <scott781@attbi.com>
Reply-To: scott781@attbi.com
To: Jeff Garzik <jgarzik@pobox.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] procps 3.0.4
In-Reply-To: <3DB21088.9090003@pobox.com>
Message-ID: <Pine.LNX.4.44.0210192200400.18992-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 19 Oct 2002, Jeff Garzik wrote:

> Albert D. Cahalan wrote:
> > The procps-2.x.x code silently gives bad output; it does NOT work.
> 
> 
> Can you be more specific?  What bugs do you see?
> 
> I am wondering if Red Hat should integrate your procps if this is so?

Hi,
  Under RedHat 8, when two cpu intensive processes are running at nice 19 
on my smp system, top will report both 100% cpu for both user and nice.  
The same is true for 7.3.
  With procps-3.0.4 this seems to be fixed.  Although the 'hide threads' 
code seems to be missing, or at least not working.  It would be nice to 
have both.

Just my $.02 USD,

Scott






