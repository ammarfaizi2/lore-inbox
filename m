Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272672AbRIGO0K>; Fri, 7 Sep 2001 10:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272673AbRIGO0A>; Fri, 7 Sep 2001 10:26:00 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:30661 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S272672AbRIGOZo>; Fri, 7 Sep 2001 10:25:44 -0400
Date: Fri, 7 Sep 2001 10:26:02 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: antirez <antirez@invece.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: epic100.c, gcc-2.95.2 compiler bug!
Message-ID: <20010907102602.J25384@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
In-Reply-To: <20010903130404.B1064@lxmayr6.informatik.tu-muenchen.de> <20010907160159.C621@lxmayr6.informatik.tu-muenchen.de> <20010907160315.D621@lxmayr6.informatik.tu-muenchen.de> <20010907161323.B31574@blu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010907161323.B31574@blu>; from antirez@invece.org on Fri, Sep 07, 2001 at 04:13:23PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2001 at 04:13:23PM +0200, antirez wrote:
> The following seems a gcc 3.0 bug, not sure it was fixed in gcc 3.01.
> 
> See the assembly generated with -O3 for the following code:

a) what does this have to do with the kernel?
b) it is not a compiler bug, read info gcc about strict-aliasing

	Jakub
