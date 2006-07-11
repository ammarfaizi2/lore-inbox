Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbWGKUNg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbWGKUNg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 16:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750947AbWGKUNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 16:13:36 -0400
Received: from beauty.rexursive.com ([203.171.74.242]:43443 "EHLO
	beauty.rexursive.com") by vger.kernel.org with ESMTP
	id S1750773AbWGKUNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 16:13:35 -0400
Subject: Re: [Suspend2-devel] Re: uswsusp history lesson
From: Bojan Smojver <bojan@rexursive.com>
To: Jason Lunz <lunz@falooley.org>
Cc: Nigel Cunningham <ncunningham@linuxmail.org>, linux-kernel@vger.kernel.org,
       suspend2-devel@lists.suspend2.net
In-Reply-To: <20060711144743.GA24187@knob.reflex>
References: <20060627133321.GB3019@elf.ucw.cz>
	 <200607100706.45789.ncunningham@linuxmail.org> <e8sj71$nad$1@sea.gmane.org>
	 <200607101620.34408.ncunningham@linuxmail.org>
	 <20060711144743.GA24187@knob.reflex>
Content-Type: text/plain
Date: Wed, 12 Jul 2006 06:13:28 +1000
Message-Id: <1152648808.2775.11.camel@coyote.rexursive.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-11 at 10:47 -0400, Jason Lunz wrote:

> I would suggest testing swsusp before each suspend2 release. It's not
> difficult at all to maintain a system that can suspend to disk using
> either method, especially if you use something like Bernard's hibernate
> scripts.

I think this is a great idea. When Suspend2 hits the -mm and the
mainline, all this should get a lot more testing, so problems will
surface more quickly.

-- 
Bojan

