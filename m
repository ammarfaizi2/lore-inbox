Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271026AbTHGWQi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 18:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271036AbTHGWQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 18:16:37 -0400
Received: from holomorphy.com ([66.224.33.161]:59286 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S271026AbTHGWQg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 18:16:36 -0400
Date: Thu, 7 Aug 2003 15:17:43 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ed Sweetman <ed.sweetman@wmich.edu>
Cc: rob@landley.net, Daniel Phillips <phillips@arcor.de>,
       Eugene Teo <eugene.teo@eugeneteo.net>,
       LKML <linux-kernel@vger.kernel.org>, kernel@kolivas.org,
       Davide Libenzi <davidel@xmailserver.org>
Subject: Re: Ingo Molnar and Con Kolivas 2.6 scheduler patches
Message-ID: <20030807221743.GO1715@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ed Sweetman <ed.sweetman@wmich.edu>, rob@landley.net,
	Daniel Phillips <phillips@arcor.de>,
	Eugene Teo <eugene.teo@eugeneteo.net>,
	LKML <linux-kernel@vger.kernel.org>, kernel@kolivas.org,
	Davide Libenzi <davidel@xmailserver.org>
References: <1059211833.576.13.camel@teapot.felipe-alfaro.com> <200308061728.04447.rob@landley.net> <200308071642.55517.phillips@arcor.de> <200308071651.07522.rob@landley.net> <3F32C752.4000403@wmich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F32C752.4000403@wmich.edu>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 07, 2003 at 05:40:34PM -0400, Ed Sweetman wrote:
> I'd just like to see less complication because less is faster and faster 
> means less overhead in kernel time.  If i have to do some of the work 
> that a bloated artificially intelligent schedular will do then i'm more 
> than happy to because that system is going to be able to scale much 
> better than something with complicated scheduling as the number of 
> processes increases.

... which only works so long as you've got root.


-- wli
