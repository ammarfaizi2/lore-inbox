Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbUBWR0c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 12:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261968AbUBWR0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 12:26:31 -0500
Received: from fw.osdl.org ([65.172.181.6]:62385 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261965AbUBWR0E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 12:26:04 -0500
Subject: Re: [Announce] New Updates to the Linux Stability Page
From: Craig Thomas <craiger@osdl.org>
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: linstab@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20040222041810.GA18525@MAIL.13thfloor.at>
References: <1077303504.19386.62.camel@bullpen.pdx.osdl.net>
	 <20040222041810.GA18525@MAIL.13thfloor.at>
Content-Type: text/plain
Organization: 
Message-Id: <1077557176.20204.2.camel@bullpen.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 23 Feb 2004 09:26:16 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-02-21 at 20:18, Herbert Poetzl wrote:
> On Fri, Feb 20, 2004 at 10:58:25AM -0800, Craig Thomas wrote:
> > The Linux Stability page continues to post test result data for the
> > post 2.6.0 kernels. http://www.osdl.org/projects/26lnxstblztn/results/
> 
> lynx spoke:
> 
>                                                          404 Not Found
>                                    Not Found
> 
>    The requested URL /projects/26lnxstblztn/results/ was not found on
>    this server.
> 
>    Additionally, a 404 Not Found error was encountered while trying to
>    use an ErrorDocument to handle the request.
>      _________________________________________________________________
> 
> 
>     Apache/2.0.47 (Red Hat Linux) Server at www.osdl.org Port 80
> 
> best,
> Herbert

We upgraded our web server to 2.6.3 over the weekend and discovered that
the problem after reboot.  The link is fixed now and our web server is
now running Linux 2.6.3 in production.


> 
> > Below lists some recent changes to the page (in case you haven't visited
> > in a while).
> > 
> > 1) 2.6.x kernels tested upon release:
> >     -mm
> >     -rc
> >     -bk
> > 2) Detaild Test Result Links show links to continual updated results to
> >    re-aim-7, tiobench, and iozone tests run in STP (1-way, 2-way, 4-way
> >    and 8-way, as appopriate)
> > 3. New links to database performance reports in the Database Performance
> >    Reports section (replaces old database section)
> > 4. New section added to link to various Lilnux kernel test report
> > 
> > If anyone knows of other useful test result information or information
> > providing a current state of the Linux kernel that can be linked from
> > this page, let me know and I'll add the link.
> > 
> > 
> > -- 
> > Craig Thomas
> > craiger@osdl.org
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
-- 
Craig Thomas
craiger@osdl.org

