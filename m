Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269488AbUINV6p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269488AbUINV6p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 17:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269247AbUINVso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 17:48:44 -0400
Received: from convulsion.choralone.org ([212.13.208.157]:59660 "EHLO
	convulsion.choralone.org") by vger.kernel.org with ESMTP
	id S266175AbUINVoL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 17:44:11 -0400
Date: Tue, 14 Sep 2004 22:43:56 +0100
From: Dave Jones <davej@redhat.com>
To: Daniel Andersen <anddan@linux-user.net>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] README (resend) - Explain new 2.6.xx.x version number
Message-ID: <20040914214356.GG13788@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Daniel Andersen <anddan@linux-user.net>,
	linux-kernel@vger.kernel.org, torvalds@osdl.org
References: <41476413.1060100@linux-user.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41476413.1060100@linux-user.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2004 at 11:35:15PM +0200, Daniel Andersen wrote:

 > +   In case of a
 > +   bug-fix release such as if eg. 2.6.8.2 is released after 2.6.9 has
 > +   been released, 2.6.9 is still to be considered the newest kernel
 > +   release of all current kernels.

This bit seems odd to me. Why would a 2.6.8.2 get released, when there's
a newer 2.6.9 which should fix whatever was relevant to get into 2.6.8.x ?

		Dave

