Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261475AbTIKRdk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 13:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbTIKRbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 13:31:43 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:8937 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S261425AbTIKRWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 13:22:16 -0400
Date: Thu, 11 Sep 2003 10:22:01 -0700
From: Frank Cusack <fcusack@fcusack.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: /proc/beep
Message-ID: <20030911102201.A7005@google.com>
References: <20030910211413.A17000@google.com> <16223.64813.248941.885060@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16223.64813.248941.885060@notabene.cse.unsw.edu.au>; from neilb@cse.unsw.edu.au on Thu, Sep 11, 2003 at 02:42:21PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 11, 2003 at 02:42:21PM +1000, Neil Brown wrote:
> On Wednesday September 10, fcusack@fcusack.com wrote:
> > If not, could at least kd_mksound be exported by default anyway?  This 
> > would allow homegrown /proc/beep's to not require any kernel mods.
> 
> The equivalent can be done with the "input layer" in 2.6.

cool!  thanks
/fc
