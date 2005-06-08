Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262158AbVFHKsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262158AbVFHKsU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 06:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262156AbVFHKsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 06:48:19 -0400
Received: from animx.eu.org ([216.98.75.249]:16059 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S262167AbVFHKsH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 06:48:07 -0400
Date: Wed, 8 Jun 2005 06:43:44 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: David Brownell <david-b@pacbell.net>
Cc: linux-usb-devel@lists.sourceforge.net, Oliver Neukum <oliver@neukum.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: kaweth fails to work on 2.6.12-rc[56]
Message-ID: <20050608104344.GB29490@animx.eu.org>
Mail-Followup-To: David Brownell <david-b@pacbell.net>,
	linux-usb-devel@lists.sourceforge.net,
	Oliver Neukum <oliver@neukum.org>, linux-kernel@vger.kernel.org
References: <20050608021140.GA28524@animx.eu.org> <20050608031101.GA28735@animx.eu.org> <200506080859.27857.oliver@neukum.org> <200506080148.23320.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506080148.23320.david-b@pacbell.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:
> On Tuesday 07 June 2005 11:59 pm, Oliver Neukum wrote:
> > Am Mittwoch, 8. Juni 2005 05:11 schrieb Wakko Warner:
> > > Wakko Warner wrote:
> > > > Seems that it is unable to send packets however I can see packets coming in.
> > > > I downgraded to 2.6.12-rc2 which works.
> 
> Don't forget to report which host controller(s) it fails with,
> and which it works with ...

See the last message I sent.  The host controller did not change, only the
kernel version.  The .config really didn't change except for the new stuff
between rc2 and newer.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
