Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272973AbTHPOYI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 10:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272974AbTHPOYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 10:24:08 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:18739 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S272973AbTHPOYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 10:24:04 -0400
Date: Sat, 16 Aug 2003 15:23:23 +0100
From: Dave Jones <davej@redhat.com>
To: Jan Rychter <jan@rychter.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Centrino support
Message-ID: <20030816142323.GA27386@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jan Rychter <jan@rychter.com>, linux-kernel@vger.kernel.org
References: <m2wude3i2y.fsf@tnuctip.rychter.com> <1060972810.29086.8.camel@serpentine.internal.keyresearch.com> <m2oeyq3bi2.fsf@tnuctip.rychter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2oeyq3bi2.fsf@tnuctip.rychter.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 15, 2003 at 01:35:17PM -0700, Jan Rychter wrote:

 > 1. Will cpufreq make it into the standard 2.4 kernels?

We asked Marcelo if he wanted it for 2.4.23, and he didn't object,
so time permitting, it could show up there next time.

 > 2. If not, will Alan incorporate swsusp into -ac kernels? (given that
 >    -ac kernels seem to have cpufreq included)

Very unlikely.

 > 3. Where does one get 2.4 cpufreq?

Normally http://www.codemonkey.org.uk/projects/cpufreq
However the box hosting that website dies within a few hours if I restart
apache (Its incredibly underpowered for the load it gets), so plans are
afoot to move it to something that can handle it. Should be back up
(for good this time hopefully) within a week or so.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
