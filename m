Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289954AbSBOQLu>; Fri, 15 Feb 2002 11:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289918AbSBOQLk>; Fri, 15 Feb 2002 11:11:40 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:30734 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S289917AbSBOQL2>;
	Fri, 15 Feb 2002 11:11:28 -0500
Date: Fri, 15 Feb 2002 08:07:11 -0800
From: Greg KH <greg@kroah.com>
To: Robert Jameson <rj@open-net.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: oops with 2.4.18-pre9-mjc2
Message-ID: <20020215160711.GD1695@kroah.com>
In-Reply-To: <20020215035135.0c26b130.rj@open-net.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020215035135.0c26b130.rj@open-net.org>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Fri, 18 Jan 2002 13:35:02 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2002 at 03:51:35AM -0500, Robert Jameson wrote:
> I have been seeing this oops from 2.4.16 -> 2.4.18-pre9, so here we go!

Known problem, sorry.  I can't duplicate this myself to try to fix this.
Other people have reported workarounds by using a different host
controller driver, or running a SMP kernel on a UP machine.

Patches gladly accepted :)

thanks,

greg k-h
