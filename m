Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280971AbRKOWF3>; Thu, 15 Nov 2001 17:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280984AbRKOWFL>; Thu, 15 Nov 2001 17:05:11 -0500
Received: from ppp-RAS1-1-13.dialup.eol.ca ([64.56.224.13]:26629 "EHLO
	node0.opengeometry.ca") by vger.kernel.org with ESMTP
	id <S281093AbRKOWEu>; Thu, 15 Nov 2001 17:04:50 -0500
Date: Thu, 15 Nov 2001 17:04:43 -0500
From: William Park <opengeometry@yahoo.ca>
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: blocks or KB?
Message-ID: <20011115170443.A1533@node0.opengeometry.ca>
Mail-Followup-To: linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20011115003434.A25883@node0.opengeometry.ca> <200111151235.fAFCZQY31248@oboe.it.uc3m.es> <20011115133133.A732@node0.opengeometry.ca> <20011115131938.M5739@lynx.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011115131938.M5739@lynx.no>; from adilger@turbolabs.com on Thu, Nov 15, 2001 at 01:19:38PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2001 at 01:19:38PM -0700, Andreas Dilger wrote:
> > Is changing 'int' to 'u64' (and all the dependent code) enough to
> > get 64-bit block devices?  I'm willing to do the work.
> 
> It is already done, please don't duplicate.  Search for 64 bit block
> devices around June of this year for a URL to Jens'/Ben's patch.
> Please repost the URL, as several people have asked.

Found it -- http://people.redhat.com/bcrl/lb/.  Strangely, it wasn't
in the linux-kernel list.

-- 
William Park, Open Geometry Consulting, <opengeometry@yahoo.ca>.
8 CPU cluster, NAS, (Slackware) Linux, Python, LaTeX, Vim, Mutt, Tin
