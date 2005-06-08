Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262140AbVFHIsl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262140AbVFHIsl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 04:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262145AbVFHIsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 04:48:41 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:10706 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S262142AbVFHIsk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 04:48:40 -0400
X-ORBL: [69.107.35.8]
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: kaweth fails to work on 2.6.12-rc[56]
Date: Wed, 8 Jun 2005 01:48:23 -0700
User-Agent: KMail/1.7.1
Cc: Oliver Neukum <oliver@neukum.org>, Wakko Warner <wakko@animx.eu.org>,
       linux-kernel@vger.kernel.org
References: <20050608021140.GA28524@animx.eu.org> <20050608031101.GA28735@animx.eu.org> <200506080859.27857.oliver@neukum.org>
In-Reply-To: <200506080859.27857.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506080148.23320.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 June 2005 11:59 pm, Oliver Neukum wrote:
> Am Mittwoch, 8. Juni 2005 05:11 schrieb Wakko Warner:
> > Wakko Warner wrote:
> > > Seems that it is unable to send packets however I can see packets coming in.
> > > I downgraded to 2.6.12-rc2 which works.

Don't forget to report which host controller(s) it fails with,
and which it works with ...
