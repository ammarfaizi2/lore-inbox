Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262443AbTHUFic (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 01:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262448AbTHUFib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 01:38:31 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:10513 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S262443AbTHUFia
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 01:38:30 -0400
Date: Wed, 20 Aug 2003 22:38:24 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: 48-bit Drives Incorrectly reporting 255 Heads?
Message-ID: <20030821053824.GA21451@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <88A7BC80FA2797498AF6D865CAD3EA43180E95@iceman.altiris.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88A7BC80FA2797498AF6D865CAD3EA43180E95@iceman.altiris.com>
User-Agent: Mutt/1.3.27i
X-Message-Flag: Boo!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 20, 2003 at 01:31:08PM -0600, John Riggs wrote:
>   With the 2.4.20 kernel, I have a 40GB disk with 240 heads, with 48-bit

I don't beleive that. 240 heads, baloney!
Unless it is a very old drive it probably has 4 or 5 heads.
Quite likely it has only 2 or 3.

A 240 head drive would have to have multiple heads per
surface or the stack of disks on the spindle would be about
5 feet tall.



-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
