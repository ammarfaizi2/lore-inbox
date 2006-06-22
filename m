Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751876AbWFVTHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751876AbWFVTHp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 15:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751819AbWFVTHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 15:07:45 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:54035 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751876AbWFVTHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 15:07:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=UL0HS2ILIniBCmOI6rdDDm1Tp8ghbgfcT20/gDFGPIvxzYIMsZnTrEcdLWSuXPwh8iOjb9VGTaMTvYT1yE3l6RjziJibGN0oGZiB0XiDitXmGL7O6VyB80wa3Kp61aRu2UOZwCzKQK4GL2LLDo1UihLvzGvTlmBAVXD3/Z64ho8=
Date: Thu, 22 Jun 2006 21:07:41 +0200
From: Frederik Deweerdt <deweerdt@free.fr>
To: Andrew Morton <akpm@osdl.org>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, pavel@suse.cz,
       linux-pm@osdl.org, stern@rowland.harvard.edu
Subject: Re: [linux-pm] swsusp regression [Was: 2.6.17-mm1]
Message-ID: <20060622190741.GC2539@slug>
References: <20060621034857.35cfe36f.akpm@osdl.org> <4499BE99.6010508@gmail.com> <20060621221445.GB3798@inferi.kami.home> <20060622061905.GD15834@kroah.com> <20060622004648.f1912e34.akpm@osdl.org> <20060622160403.GB2539@slug> <20060622092506.da2a8bf4.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060622092506.da2a8bf4.akpm@osdl.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2006 at 09:25:06AM -0700, Andrew Morton wrote:
> On Thu, 22 Jun 2006 18:04:03 +0200
> Frederik Deweerdt <deweerdt@free.fr> wrote:
> > 2.6.17: oops
> > 2.6.17.1: oops
> 
> 2.6.17 wasn't supposed to oops.  Do you have details on this?
> 
No, sorry I didn't have a serial cable handy. I'll post the 
.config and the oops tomorrow.

Regards,
Frederik
