Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262032AbVF1IkS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262032AbVF1IkS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 04:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbVF1Ijh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 04:39:37 -0400
Received: from smtpout3.uol.com.br ([200.221.4.194]:9214 "EHLO smtp.uol.com.br")
	by vger.kernel.org with ESMTP id S261907AbVF1Ihr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 04:37:47 -0400
Date: Tue, 28 Jun 2005 05:37:45 -0300
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
       stefanr@s5r6.in-berlin.de
Subject: Re: Problems with Firewire and -mm kernels
Message-ID: <20050628083745.GD21412@ime.usp.br>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
	stefanr@s5r6.in-berlin.de
References: <20050626040329.3849cf68.akpm@osdl.org> <42BE99C3.9080307@trex.wsi.edu.pl> <20050627025059.GC10920@ime.usp.br> <20050627164540.7ded07fc.akpm@osdl.org> <20050628010052.GA3947@ime.usp.br> <20050627202226.43ebd761.akpm@osdl.org> <42C0FF50.7080300@s5r6.in-berlin.de> <20050628004650.18282bd6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050628004650.18282bd6.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 28 2005, Andrew Morton wrote:
> Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:
> >
> > >  ieee1394: Node changed: 0-01:1023 -> 0-00:1023
> > >  ieee1394: Node suspended: ID:BUS[0-00:1023]  GUID[0050c501e00010e8]
> > 
> > What caused these two messages? Did you disconnect the drive at this
> > point? 
> 
> No, there is no device plugged into the machine.

Right, at that time I had already disconnected the drive.

> Maybe the G5 has some internal 1394 device?  It would be news to me if so.

Heh, I don't have the money for a G5. :-) I'm using this on a vanilla x86
with a Duron 1.1GHz (which I recently upgraded from a Duron 600MHz).

Perhaps I should provide more information regarding my system? If yes,
please let me know what and I will do my best.


Thanks, Rogério.

-- 
Rogério Brito : rbrito@ime.usp.br : http://www.ime.usp.br/~rbrito
Homepage of the algorithms package : http://algorithms.berlios.de
Homepage on freshmeat:  http://freshmeat.net/projects/algorithms/
