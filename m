Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbUAXVJt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 16:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbUAXVJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 16:09:49 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:42993 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP id S261929AbUAXVJs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 16:09:48 -0500
Date: Sat, 24 Jan 2004 23:09:40 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Diego Calleja <grundig@teleline.es>
Cc: Felix von Leitner <felix-kernel@fefe.de>, linux-kernel@vger.kernel.org
Subject: Re: Request: I/O request recording
Message-ID: <20040124210940.GX11115091@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Diego Calleja <grundig@teleline.es>,
	Felix von Leitner <felix-kernel@fefe.de>,
	linux-kernel@vger.kernel.org
References: <20040124181026.GA22100@codeblau.de> <20040124211156.042a4ff2.grundig@teleline.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040124211156.042a4ff2.grundig@teleline.es>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 24, 2004 at 09:11:56PM +0100, you [Diego Calleja] wrote:
> 
> That's exactly what XP does (and Mac OS X, for that matter).
> And it really works (ie: you can notice it)
> 
> XP records what the OS does in the first 2 minutes (or so). The next
> time it boots, it tries to load the files that he knows that are going
> to be used. The same for an app that is frecuently used: it records
> what the app does, and it optimizes the startup of that app. 
> Take a look at: (search prefetch)
> http://msdn.microsoft.com/library/default.asp?url=/library/en-us/appendix/hh/appendix/enhancements5_0qhx.asp
> http://msdn.microsoft.com/msdnmag/issues/01/12/xpkernel/default.aspx

It's perhaps worth pointing out that XP not only uses the boot (or
application launch) traces to prefetch the data on next boot (application
launch) but also to reorder the data on disk optimally via XP's
defragmenter. 

And XP is noticeable faster to boot than (say) W2000.


-- v --

v@iki.fi
