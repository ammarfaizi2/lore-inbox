Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266902AbUGVUKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266902AbUGVUKY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 16:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267195AbUGVUKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 16:10:24 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:56170 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S266902AbUGVUKX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 16:10:23 -0400
Date: Fri, 23 Jul 2004 00:11:06 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Pragnesh Sampat <pragnesh.sampat@timesys.com>
Cc: dank@kegel.com, hollisb@us.ibm.com, christopher.faylor@timesys.com,
       "Povolotsky, Alexander" <alexander.povolotsky@marconi.com>,
       crossgcc <crossgcc@sources.redhat.com>,
       "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>,
       Andrew Morton <akpm@osdl.org>, bert hubert <ahu@ds9a.nl>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: case-sensitive file names during build
Message-ID: <20040722221106.GD7073@mars.ravnborg.org>
Mail-Followup-To: Pragnesh Sampat <pragnesh.sampat@timesys.com>,
	dank@kegel.com, hollisb@us.ibm.com, christopher.faylor@timesys.com,
	"Povolotsky, Alexander" <alexander.povolotsky@marconi.com>,
	crossgcc <crossgcc@sources.redhat.com>,
	"linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>,
	Andrew Morton <akpm@osdl.org>, bert hubert <ahu@ds9a.nl>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
References: <3D848382FB72E249812901444C6BDB1D036EDF21@exchange.timesys.com> <1090524458.8679.23.camel@pss-pc.timesys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1090524458.8679.23.camel@pss-pc.timesys>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2004 at 03:27:38PM -0400, Pragnesh Sampat wrote:
> 
> Dan,
> 
> We have some patches that we use at TimeSys that allow a linux kernel to
> build on cygwin.  They fall under:

Please copy me on all kbuild patches that enables cygwin builds.

	Sam
