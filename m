Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269199AbUIHXTD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269199AbUIHXTD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 19:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269207AbUIHXTD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 19:19:03 -0400
Received: from convulsion.choralone.org ([212.13.208.157]:53264 "EHLO
	convulsion.choralone.org") by vger.kernel.org with ESMTP
	id S269199AbUIHXTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 19:19:00 -0400
Date: Thu, 9 Sep 2004 00:18:59 +0100
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix NULL dereference in OSS v_midi driver
Message-ID: <20040908231859.GA29616@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	linux-kernel@vger.kernel.org
References: <200409011551.i81FpNha000690@delerium.codemonkey.org.uk> <20040907155239.GE19354@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040907155239.GE19354@MAIL.13thfloor.at>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2004 at 05:52:40PM +0200, Herbert Poetzl wrote:
 > On Wed, Sep 01, 2004 at 04:51:23PM +0100, Dave Jones wrote:
 > > Spotted with the source checker from Coverity.com.
 > 
 > apologies for the OT question:
 > 
 > how do you get the code checked with the source code
 > checker from Coverity.com? 

AFAIK, the current results are run on a vanilla 2.6.4 tree.

 > and would it be possible to have other kernel branches
 > or specific kernel patches checked too?

I've asked them if they'd rerun the tests on something more
recent a few times, but they've other more important things
to do it seems.

		Dave

