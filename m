Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750832AbWC2TJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbWC2TJJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 14:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbWC2TJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 14:09:08 -0500
Received: from CS-LINUX.ubishops.ca ([206.167.194.130]:8855 "EHLO
	cs-linux.ubishops.ca") by vger.kernel.org with ESMTP
	id S1750832AbWC2TJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 14:09:07 -0500
Date: Wed, 29 Mar 2006 08:48:41 -0800
From: Greg KH <greg@kroah.com>
To: "Paul D. Smith" <psmith@gnu.org>
Cc: Arthur Othieno <apgo@patchbomb.org>, Sam Ravnborg <sam@ravnborg.org>,
       linux-kernel@vger.kernel.org, kernel@kolivas.org, stable@kernel.org
Subject: Re: [stable] Re: [PATCH] change kbuild to not rely on incorrect GNU make behavior
Message-ID: <20060329164841.GA2561@kroah.com>
References: <E1FG1UQ-00045B-5P@fencepost.gnu.org> <20060305231312.GA25673@mars.ravnborg.org> <20060329131501.GA8537@krypton> <17450.35947.966666.328091@lemming.engeast.baynetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17450.35947.966666.328091@lemming.engeast.baynetworks.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2006 at 08:32:27AM -0500, Paul D. Smith wrote:
> 
> On the gripping hand, it's quite possible to provide a significantly
> smaller, targeted patch that fixes just the most egregious problem with
> only two lines changed, if the -stable team was interested in that
> instead.

That sounds good, and if it solves problems for people, should be
acceptable.

thanks,

greg k-h
