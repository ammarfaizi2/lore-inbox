Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262660AbSJBXPX>; Wed, 2 Oct 2002 19:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262669AbSJBXPX>; Wed, 2 Oct 2002 19:15:23 -0400
Received: from holomorphy.com ([66.224.33.161]:1989 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262660AbSJBXPW>;
	Wed, 2 Oct 2002 19:15:22 -0400
Date: Wed, 2 Oct 2002 16:16:27 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Guillaume Boissiere <boissiere@adiglobal.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [STATUS 2.5]  October 2, 2002
Message-ID: <20021002231627.GB10722@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Guillaume Boissiere <boissiere@adiglobal.com>,
	linux-kernel@vger.kernel.org
References: <3D9B2FBD.12828.5DF75E@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3D9B2FBD.12828.5DF75E@localhost>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2002 at 05:41:17PM -0400, Guillaume Boissiere wrote:
> o Alpha  Parallelizing page replacement  (Andrew Morton, Momchil Velikov, Dave Hansen, 
> William Lee Irwin)  

Alpha? This is not only done, but merged!


On Wed, Oct 02, 2002 at 05:41:17PM -0400, Guillaume Boissiere wrote:
> o Alpha  Remove the global tasklist  (Ingo Molnar, William Lee Irwin)  

Well, there's a lot less reliance on it in the kernel now, which
probably means it's more than Beta even. I'm not sure removing the
global tasklist entirely is still the goal, so it may just be done.


Bill
