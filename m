Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291394AbSCOL6o>; Fri, 15 Mar 2002 06:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291471AbSCOL6f>; Fri, 15 Mar 2002 06:58:35 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:64704 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S291394AbSCOL63>;
	Fri, 15 Mar 2002 06:58:29 -0500
Date: Fri, 15 Mar 2002 17:37:48 +0530
From: "Vamsi Krishna S ." <vamsi@in.ibm.com>
To: "Vamsi Krishna S." <vamsi_krishna@in.ibm.com>
Cc: Jeff Jenkins <jefreyr@pacbell.net>, linux-kernel@vger.kernel.org
Subject: Re: Thread registers dumped to core-file
Message-ID: <20020315173748.A3472@in.ibm.com>
Reply-To: vamsi@in.ibm.com
In-Reply-To: <HFEPKLGPJDEHEGCKLKCCMEDLCCAA.jefreyr@pacbell.net> <200203090636.g296aSV273332@westrelay01.boulder.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200203090636.g296aSV273332@westrelay01.boulder.ibm.com>; from vamsi_krishna@in.ibm.com on Sat, Mar 09, 2002 at 12:15:49PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have posted this patch a few minutes back to the list.
-- 
Vamsi Krishna S.
Linux Technology Center,
IBM Software Lab, Bangalore.
Ph: +91 80 5262355 Extn: 3959
Internet: vamsi@in.ibm.com

On Sat, Mar 09, 2002 at 12:15:49PM +0530, Vamsi Krishna S. wrote:
> [This is an email copy of a Usenet post to "mailinglists.external.linux-kernel"]
> 
> We are working on dumping the register state (including FPU and SSE regs)
> of all threads to the elf core file. We should release the patch fairly
> soon.
> 
> Vamsi Krishna S.
> Linux Technology Center
> IBM Software Labs, Bangalore, India
> 
> On Fri, 08 Mar 2002 21:52:48 +0530, Jeff Jenkins wrote:
> 
> > I was chatting with the GDB folks, and they mentioned there is no code in the
> > kernel which
> > will dump *all* thread registers to a core file.  Anyone have such code that
> > could be used in a patch?
> > 
> > Being able to get at the state of all threads in a process at core-dump time is
> > invaluable!
> > Anyone else been griping about this?
> > 
> > Rah!
> > 
> > -- jrj

