Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261334AbVGGUlV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbVGGUlV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 16:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261373AbVGGUkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 16:40:51 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15592 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261437AbVGGUk1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 16:40:27 -0400
Date: Thu, 7 Jul 2005 16:40:17 -0400
From: Dave Jones <davej@redhat.com>
To: st3@riseup.net
Cc: linux-kernel@vger.kernel.org, cpufreq@lists.linux.org.uk
Subject: Re: enhanced intel speedstep feature was Re: speedstep-centrino on dothan
Message-ID: <20050707204017.GB29142@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, st3@riseup.net,
	linux-kernel@vger.kernel.org, cpufreq@lists.linux.org.uk
References: <20050706112202.33d63d4d@horst.morte.male> <42CC37FD.5040708@tmr.com> <20050706211159.GF27630@redhat.com> <20050706235557.0c122d33@horst.morte.male> <20050707220027.413343d4@horst.morte.male> <20050707200648.GA29142@redhat.com> <20050707222225.5b3113e0@horst.morte.male>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050707222225.5b3113e0@horst.morte.male>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2005 at 10:22:25PM +0200, st3@riseup.net wrote:

 > > This hasn't been seen to save any power whatsoever that I've seen.
 > 
 > It drops down power rating by 1500-1800mW on my Toshiba Satellite A50
 > while idling at 400MHz.
 > 
 > > I've heard a few reports that it reduces heat for a few folks, but
 > > betting on it increasing your battery life is probably a push.
 > 
 > Just a latest question: can be p4-clockmod used together with
 > speedstep-centrino? If not, would it make any sense to patch
 > speedstep-centrino to use this feature too?

There was some discussion on cpufreq list long ago to make cpufreq
drivers stackable, but it's never been a high enough priority for
anyone to actually do the work.

		Dave
