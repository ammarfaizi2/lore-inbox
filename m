Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318000AbSFSUez>; Wed, 19 Jun 2002 16:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318001AbSFSUey>; Wed, 19 Jun 2002 16:34:54 -0400
Received: from pc-62-31-66-56-ed.blueyonder.co.uk ([62.31.66.56]:7814 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S318000AbSFSUex>; Wed, 19 Jun 2002 16:34:53 -0400
Date: Wed, 19 Jun 2002 21:34:48 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Christopher Li <chrisl@gnuchina.org>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Alexander Viro <viro@math.psu.edu>,
       DervishD <raul@pleyades.net>,
       Linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: Shrinking ext3 directories
Message-ID: <20020619213448.A22803@redhat.com>
References: <20020619113734.D2658@redhat.com> <Pine.LNX.4.44.0206191256550.20859-100000@localhost.localdomain> <20020619211051.E5119@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020619211051.E5119@redhat.com>; from sct@redhat.com on Wed, Jun 19, 2002 at 09:10:51PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 19, 2002 at 09:10:51PM +0100, Stephen C. Tweedie wrote:

> cvs -d :ext:FOO@cvs.gkernel.sourceforge.net:/cvsroot/gkernel co ext3
> The branches being used are
> 
> 	cvs up -r ext3-1_0-branch	# HEAD of ext3 development
> 	cvs up -r features-branch	# For htree, ACLs etc

And one other thing: the subdirectories tools/, testing/ and scripts/
on the cvs trunk contain various tools for testing and stressing the
filesystem and VM.

--Stephen
