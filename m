Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271636AbRH3FYG>; Thu, 30 Aug 2001 01:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271639AbRH3FX5>; Thu, 30 Aug 2001 01:23:57 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:57352 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S271636AbRH3FXo>;
	Thu, 30 Aug 2001 01:23:44 -0400
Date: Wed, 29 Aug 2001 22:22:06 -0700
From: Greg KH <greg@kroah.com>
To: Aaron Lehmann <aaronl@vitelus.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Diet /sbin/hotplug package released
Message-ID: <20010829222206.B14791@kroah.com>
In-Reply-To: <20010829120440.B12825@kroah.com> <20010829221246.B30945@vitelus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010829221246.B30945@vitelus.com>; from aaronl@vitelus.com on Wed, Aug 29, 2001 at 10:12:46PM -0700
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2001 at 10:12:46PM -0700, Aaron Lehmann wrote:
> On Wed, Aug 29, 2001 at 12:04:40PM -0700, Greg KH wrote:
> >    is 59221 bytes.  The current linux-hotplug system needs this file,
> >    plus all of the linux-hotplug scripts and bash and awk to work.
> 
> Hrm, why does it use bash-specific shell features? That's very bad.
> POSIX would be a much cleaner spec to conform to.

I don't know if it uses bash-specific features, I haven't tried it on
any other shell (and am not the main author of the shell scripts).

Why would POSIX "cleanness" matter for these scripts?

thanks,

greg k-h
