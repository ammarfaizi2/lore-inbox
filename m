Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbUDNUm7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 16:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbUDNUm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 16:42:59 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:38073 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S261682AbUDNUm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 16:42:58 -0400
Date: Wed, 14 Apr 2004 21:42:12 +0100
From: Dave Jones <davej@redhat.com>
To: walt <wa1ter@myrealbox.com>, linux-kernel@vger.kernel.org
Subject: Re: [2.6.5-bk]  'modules_install' failed to install modules
Message-ID: <20040414204212.GM24970@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	walt <wa1ter@myrealbox.com>, linux-kernel@vger.kernel.org
References: <407D5B7F.107@myrealbox.com> <20040414161827.GA2229@mars.ravnborg.org> <20040414170010.GA23419@redhat.com> <20040414202554.GA12020@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040414202554.GA12020@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2004 at 10:25:54PM +0200, Sam Ravnborg wrote:

 > This does not match your failure report 100%.
 > I assume what you did was something like:
 > 
 > make bzImage
 > make modules
 > make install		<= This would trigger the above case
 > make modules_install

That's quite possible.

 > Anyway here is the fix.
 > Please let me know if you still se problems.

I'll give it a shot.

		Dave

