Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261217AbVABNDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbVABNDL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 08:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbVABNDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 08:03:11 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:6543 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S261217AbVABNDF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 08:03:05 -0500
Date: Sun, 2 Jan 2005 14:03:04 +0100
From: bert hubert <ahu@ds9a.nl>
To: Indrek Kruusa <indrek.kruusa@tuleriit.ee>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Question: advancements in proven concepts
Message-ID: <20050102130304.GA27255@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Indrek Kruusa <indrek.kruusa@tuleriit.ee>,
	linux-kernel@vger.kernel.org
References: <41D7E3EF.8000700@tuleriit.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41D7E3EF.8000700@tuleriit.ee>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 02, 2005 at 02:07:11PM +0200, Indrek Kruusa wrote:

> Is there a place for linux kernel community where ideas about the needed 
> advancements in those proven concepts can be presented to the world in 
> nice, structured and easily readable way? Or is this the professional 

Ottawa Linux Symposium comes closest, together with Linux Conf Australia.
OLD publishes proceedings where people present their ideas, sometimes
already implemented, sometimes planned.

Otherwise, people have been known to present their ideas to this list. An
example is the epoll work which was presented on this page
http://www.xmailserver.org/linux-patches/nio-improve.html

> property of the kernel programmer to not ask a question about the 
> "healtiness" of some POSIX thing or not to give a hint for better 
> hardware implementation? Well, this last question is a little nagging.

A lot of it is informal. I know some linux kernel developers are pretty
close with hardware manufacturers and especially AMD invested a lot of time
and effort in making sure the Opteron design was fit for linux, which mostly
worked.

Linus mentioned a few years ago that a lot of these exchanges occurred in
hallways of conferences, suddenly some people would jump him and say "we're
from [ big company ] and we'd like linux to do this" or "we're from [ big
company ] and we're wondering how we should design our hardware". Linus then
called for opening up this process, which has happened for a bit. OSDL may
also be a venue.

LT> It would have been nice if Intel had added a
LT> "single-step" bit to %db7, and then just or'ed in the values of TF and the
LT> new flag when deciding to single-step.
> 
> Maybe this idea have been said out just for fun  (btw, I have one book 
> which have similar title :) ) but why not collect such things together? 

Rest assured that this list has subscribers @ all relevant processor
manufacturers. But there is nothing formal, it is not the linux way to set
up committees or whatever, except perhaps for OSDL.

Regards,

bert

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
