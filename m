Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263713AbRFHAAg>; Thu, 7 Jun 2001 20:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263723AbRFHAAQ>; Thu, 7 Jun 2001 20:00:16 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:51983 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S263713AbRFHAAF>; Thu, 7 Jun 2001 20:00:05 -0400
Date: Fri, 8 Jun 2001 01:59:33 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: VM suggestion...
Message-ID: <20010608015933.F10688@arthur.ubicom.tudelft.nl>
In-Reply-To: <3B1FEB7E.D06B10A2@mandrakesoft.com> <Pine.LNX.4.21.0106071631150.1156-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0106071631150.1156-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Thu, Jun 07, 2001 at 04:36:05PM -0300
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2001 at 04:36:05PM -0300, Marcelo Tosatti wrote:
> On Thu, 7 Jun 2001, Jeff Garzik wrote:
> > Statistics like this are cheap to use in runtime and should provide
> > concrete information rather than guesses and estimations...
> 
> I've been using LTT (Linux Trace Toolkit) to do similar stuff. 

But you can't expect everybody to use LTT. If you just make a couple of
counters and give an easy way to get the values from userspace (proc,
sysctl, syslog), you'll get bug reports with real information. IMHO
data from real world workloads make more sense than "it doesn't work"
reports.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
