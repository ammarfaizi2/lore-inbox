Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264881AbTFQSpe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 14:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264882AbTFQSpe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 14:45:34 -0400
Received: from fe7.rdc-kc.rr.com ([24.94.162.160]:15879 "EHLO mail7.kc.rr.com")
	by vger.kernel.org with ESMTP id S264881AbTFQSpd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 14:45:33 -0400
Date: Tue, 17 Jun 2003 13:59:03 -0500
From: Greg Norris <haphazard@kc.rr.com>
To: Paul Larson <plars@linuxtestproject.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, rml@tech9.net
Subject: Re: 2.5.72 oops (scheduling while atomic)
Message-ID: <20030617185903.GA32280@glitch.localdomain>
Mail-Followup-To: Paul Larson <plars@linuxtestproject.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, rml@tech9.net
References: <20030617143551.GA3057@glitch.localdomain> <1055873875.948.13.camel@plars>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1055873875.948.13.camel@plars>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 17, 2003 at 01:17:54PM -0500, Paul Larson wrote:
> I submitted a bug on this a while back, bug #800 in bugme:
> http://bugme.osdl.org/show_bug.cgi?id=800
> 
> I saw it starting with 2.5.70-bk15.  It looks like it did not have this
> problem in 2.5.70-bk14.  Does this seem to be the case with you as
> well?  I have not yet had time to hunt down more than is in that bug
> report.

It certainly looks like the same problem.  I'll try out 2.5.70-bk14/15
sometime tonite if I have a chance, and see if that's where it breaks
for me as well.  In the meantime, I'm comparing our .config files.

Thanx!
