Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264371AbTH1XMp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 19:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264378AbTH1XMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 19:12:45 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:61189
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S264371AbTH1XMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 19:12:44 -0400
Date: Thu, 28 Aug 2003 16:12:39 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Breno <brenosp@brasilsec.com.br>,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: non-exec stack
Message-ID: <20030828231239.GG21352@matchmail.com>
Mail-Followup-To: Chris Wright <chrisw@osdl.org>,
	Breno <brenosp@brasilsec.com.br>,
	Kernel List <linux-kernel@vger.kernel.org>
References: <001801c3860b$ab8e5560$3fdfa7c8@bsb.virtua.com.br> <20030828151501.A24595@osdlab.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030828151501.A24595@osdlab.pdx.osdl.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 28, 2003 at 03:15:01PM -0700, Chris Wright wrote:
> * Breno (brenosp@brasilsec.com.br) wrote:
> > Hi , Is there an source that allow non-exec stack for linux ? like openbsd
> > do.
> 
> Have you looked at Openwall Linux or exec-shield?
> 
> http://www.openwall.com/linux/
> http://people.redhat.com/mingo/exec-shield/
> 
> of course, neither is a complete security solution, just a small bit of
> protection.

What about ingo's exec shield patch that was going around a while ago?  Has
that died?
