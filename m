Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314077AbSE2RQC>; Wed, 29 May 2002 13:16:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314082AbSE2RQC>; Wed, 29 May 2002 13:16:02 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:50180 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S314077AbSE2RQB>;
	Wed, 29 May 2002 13:16:01 -0400
Date: Wed, 29 May 2002 10:14:37 -0700
From: Greg KH <greg@kroah.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-pre9, still USB freeze
Message-ID: <20020529171437.GB18466@kroah.com>
In-Reply-To: <Pine.LNX.4.21.0205281905260.7798-100000@freak.distro.conectiva> <20020529053732.GH6521@marowsky-bree.de> <20020529060608.GB15260@kroah.com> <20020529145010.21d01e80.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Wed, 01 May 2002 15:30:15 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2002 at 02:50:10PM +0200, Stephan von Krawczynski wrote:
> Hello,
> 
> as noted for pre8, pre9 freezes still, when connecting a sandisk SDDR-05 to USB
> (only device attached), and trying to mount some compact-flash. Or, as an
> alternative test, even with no compact flash inserted, when starting up
> xcdroast. Both completely freezes the machine.

Does 2.5.18 show this same freeze?

thanks,

greg k-h
