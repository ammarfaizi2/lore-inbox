Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310489AbSCGTqf>; Thu, 7 Mar 2002 14:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310490AbSCGTqP>; Thu, 7 Mar 2002 14:46:15 -0500
Received: from mailhost.tue.nl ([131.155.2.5]:60777 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S310489AbSCGTqO>;
	Thu, 7 Mar 2002 14:46:14 -0500
Date: Thu, 7 Mar 2002 20:46:02 +0100
From: Guest section DW <dwguest@win.tue.nl>
To: Hubertus Franke <frankeh@watson.ibm.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, rajancr@us.ibm.com,
        linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: Fwd: [Lse-tech] get_pid() performance fix
Message-ID: <20020307194602.GA13092@win.tue.nl>
In-Reply-To: <20020305145004.BFA503FE06@smtp.linux.ibm.com> <20020307143404.A8FFF3FE06@smtp.linux.ibm.com> <20020307145449.GA13062@win.tue.nl> <20020307190635.9DE533FE08@smtp.linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020307190635.9DE533FE08@smtp.linux.ibm.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2002 at 02:07:38PM -0500, Hubertus Franke wrote:
> On Thursday 07 March 2002 09:54 am, Guest section DW wrote:
> > On Thu, Mar 07, 2002 at 09:35:09AM -0500, Hubertus Franke wrote:
> > ...
> >
> > Long ago I submitted a patch that changed the max pid from 15 bits to
> > 24 or 30 bits or so. (And of course removed the inefficiency noticed
> > by some people in the current thread.)

> I don't think that will solve the N^2 problem

Do you understand "inefficiency"? And "remove"?
