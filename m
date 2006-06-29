Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933098AbWF2XmY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933098AbWF2XmY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 19:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933100AbWF2XmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 19:42:24 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56767 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S933098AbWF2XmX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 19:42:23 -0400
Date: Thu, 29 Jun 2006 19:42:09 -0400
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Rene Herman <rene.herman@keyaccess.nl>, gregoire.favre@gmail.com,
       linux-kernel@vger.kernel.org, kraxel@suse.de
Subject: Re: 2.6.17-mm4 undefined reference to `alternatives_smp_module_del'
Message-ID: <20060629234209.GA30801@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>,
	Rene Herman <rene.herman@keyaccess.nl>, gregoire.favre@gmail.com,
	linux-kernel@vger.kernel.org, kraxel@suse.de
References: <20060629122721.GA18671@gmail.com> <20060629154247.1bf8eccf.akpm@osdl.org> <44A46130.8090102@keyaccess.nl> <20060629164054.3b2e07d4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060629164054.3b2e07d4.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2006 at 04:40:54PM -0700, Andrew Morton wrote:

 > > > Should be a stub in a header file, which would fix this problem too.
 > > 
 > > Gerd Hoffmann already did this and I suppose it's in some upstream tree 
 > > somewhere:
 > I'd say it got lost.
 > 
 > > http://marc.theaimsgroup.com/?l=linux-kernel&m=114743413932319&w=2

Ha, I was just reconstructing the exact same patch.

 > <snarf>

Yay!

		Dave


-- 
http://www.codemonkey.org.uk
