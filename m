Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261850AbSJMU62>; Sun, 13 Oct 2002 16:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261851AbSJMU62>; Sun, 13 Oct 2002 16:58:28 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:55570 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261850AbSJMU62>;
	Sun, 13 Oct 2002 16:58:28 -0400
Date: Sun, 13 Oct 2002 13:59:33 -0700
From: Greg KH <greg@kroah.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Summit support for 2.5 [0/4]
Message-ID: <20021013205933.GA24140@kroah.com>
References: <39770000.1034541701@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39770000.1034541701@flay>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 13, 2002 at 01:41:41PM -0700, Martin J. Bligh wrote:
> I will invest some serious effort and time in cleanup after the feature freeze,
> including investigating using the subarch support which I know some people
> would like to see done.

Any reason why most of these changes couldn't be moved to the subarch
code now?

thanks,

greg k-h
