Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751438AbWFPOly@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbWFPOly (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 10:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbWFPOly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 10:41:54 -0400
Received: from ptb-relay01.plus.net ([212.159.14.212]:22152 "EHLO
	ptb-relay01.plus.net") by vger.kernel.org with ESMTP
	id S1751438AbWFPOlx (ORCPT <rfc822;linux-Kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 10:41:53 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: sena seneviratne <auntvini@cel.usyd.edu.au>
Subject: Re: a newbie with the kernel--a few questions
Date: Fri, 16 Jun 2006 15:41:39 +0100
User-Agent: KMail/1.9.3
Cc: "Tyler Littlefield" <compgeek13@gmail.com>, linux-Kernel@vger.kernel.org
References: <5.1.1.5.2.20060616111106.04488d40@brain.sedal.usyd.edu.au> <5.1.1.5.2.20060616132151.04502988@brain.sedal.usyd.edu.au>
In-Reply-To: <5.1.1.5.2.20060616132151.04502988@brain.sedal.usyd.edu.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606161541.39498.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> At 09:12 PM 6/15/2006 -0600, you wrote:
> >OK, I am pretty good with c. My goal here is... Well, when a user types
> > who, I don't want it to work, unless its root. (easy to change) but I
> > want some security like that in the kernel. Also, I want to limit it to
> > when the user types ps, they can't get everyone's processes, but jsut
> > there own, unless of course, they are root.
> >Thanks,

Might also be worth looking at patches like GrSecurity which make general 
policy changes (such as these) and are well tested and robust.

-- 
Cheers,
Alistair.

Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
