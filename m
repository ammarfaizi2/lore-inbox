Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264944AbTFLSos (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 14:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264946AbTFLSos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 14:44:48 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:19121 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S264944AbTFLSos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 14:44:48 -0400
Date: Thu, 12 Jun 2003 19:58:19 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: mok@imsb.au.dk
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: fatal error with nForce2 system
Message-ID: <20030612185819.GA24566@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>, mok@imsb.au.dk,
	linux-kernel@vger.kernel.org
References: <6F57D57C-9D02-11D7-AF71-003065529A02@stofanet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6F57D57C-9D02-11D7-AF71-003065529A02@stofanet.dk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 12, 2003 at 08:19:41PM +0200, Morten Kjeldgaard wrote:

 >  I first reported the problem to nVidia, and they were very quick to 
 > repond. I was in contact with a very helpful engineer, and after some 
 > experimentation we concluded that the problem is probably not in their 
 > drivers, since the machine crashes under the same circumstances without 
 > the nvidia drivers loaded. However, I have only seen error messages in 
 > the syslog when the nvidia driver is loaded, but that is most likely a 
 > coincidence.

Unfortunatly, they have the Linux kernel source, we do not have their
source. There's nothing anyone here can do to debug this problem unless
you can repeat it without ever having had the nvidia module loaded.

		Dave

