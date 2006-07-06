Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750899AbWGFWIB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbWGFWIB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 18:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750904AbWGFWIB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 18:08:01 -0400
Received: from mx1.redhat.com ([66.187.233.31]:1251 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750899AbWGFWIA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 18:08:00 -0400
Date: Thu, 6 Jul 2006 18:07:58 -0400
From: Dave Jones <davej@redhat.com>
To: Peter Jones <pjones@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: lockdep: bdev->bd_mutex deadlock
Message-ID: <20060706220758.GD30500@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Peter Jones <pjones@redhat.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <1152221477.25480.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152221477.25480.9.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2006 at 05:31:17PM -0400, Peter Jones wrote:
 > I got this traceback from lockdep while running last night's Fedora Core
 > (rawhide) kernel, which is version 2.6.17-1.2356.fc6 .  (I believe it's
 > based on a fairly current git pull, davej will know for sure.)

it's .18rc1.

		Dave

-- 
http://www.codemonkey.org.uk
