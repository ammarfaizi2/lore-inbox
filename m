Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265680AbTB0RpT>; Thu, 27 Feb 2003 12:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265686AbTB0RpT>; Thu, 27 Feb 2003 12:45:19 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:63750 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265680AbTB0RpS>;
	Thu, 27 Feb 2003 12:45:18 -0500
Date: Thu, 27 Feb 2003 09:47:05 -0800
From: Greg KH <greg@kroah.com>
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/8] dm: __LOW macro fix no. 2
Message-ID: <20030227174705.GB22191@kroah.com>
References: <20030226170537.GA8289@fib011235813.fsnet.co.uk> <20030226171249.GG8369@fib011235813.fsnet.co.uk> <20030226181454.GA16350@kroah.com> <20030227095522.GA6312@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030227095522.GA6312@fib011235813.fsnet.co.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2003 at 09:55:22AM +0000, Joe Thornber wrote:
> Greg,
> 
> Any happier with this ?  The second hunk of the patch may disappear at
> some point.

Much nicer, thanks.

greg k-h
