Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267934AbTBRSf7>; Tue, 18 Feb 2003 13:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267948AbTBRSfj>; Tue, 18 Feb 2003 13:35:39 -0500
Received: from ip68-13-105-80.om.om.cox.net ([68.13.105.80]:60290 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S267934AbTBRSet>; Tue, 18 Feb 2003 13:34:49 -0500
Date: Tue, 18 Feb 2003 06:45:10 -0600 (CST)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@localhost.localdomain
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Is an alternative module interface needed/possible?
In-Reply-To: <20030218111215.T2092@almesberger.net>
Message-ID: <Pine.LNX.4.44.0302180638220.2649-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Feb 2003, Werner Almesberger wrote:

> Good :-) I want to avoid modules as much as possible, because
> they've extensively been tackled in the past (which didn't help
> much making the interfaces better), and also because they're
> just a bit too political an issue.
> 
> Okay, this brings us to the issue of broken interfaces. Do we
> have agreement that there are cases where interfaces like
> remove_proc_entry, in their current state, cannot be used
> correctly ?

I hope this discussion is taking place in the context of looking forward 
towards something to implement in 2.7.  IMHO we are much too late in the 
2.5 cycle to implement this now.  

