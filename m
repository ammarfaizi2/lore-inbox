Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272039AbRH3F1g>; Thu, 30 Aug 2001 01:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272073AbRH3F10>; Thu, 30 Aug 2001 01:27:26 -0400
Received: from vitelus.com ([64.81.243.207]:53514 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S272039AbRH3F1K>;
	Thu, 30 Aug 2001 01:27:10 -0400
Date: Wed, 29 Aug 2001 22:27:26 -0700
From: Aaron Lehmann <aaronl@vitelus.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Diet /sbin/hotplug package released
Message-ID: <20010829222726.C30945@vitelus.com>
In-Reply-To: <20010829120440.B12825@kroah.com> <20010829221246.B30945@vitelus.com> <20010829222206.B14791@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010829222206.B14791@kroah.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2001 at 10:22:06PM -0700, Greg KH wrote:
> Why would POSIX "cleanness" matter for these scripts?

Believe it or not, some people don't use bash as /bin/sh, or at all.
I notice that /etc/hotplug/hotplug.functions uses #!/bin/bash, which
is better than pretending to be an "sh" script and using bashisms.
