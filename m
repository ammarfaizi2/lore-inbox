Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262116AbVCNLUS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbVCNLUS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 06:20:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbVCNLUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 06:20:18 -0500
Received: from poup.poupinou.org ([195.101.94.96]:62477 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP id S262116AbVCNLUN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 06:20:13 -0500
Date: Mon, 14 Mar 2005 12:19:50 +0100
To: Eric Piel <Eric.Piel@tremplin-utc.net>
Cc: Jan De Luyck <lkml@kcore.org>, davej@redhat.com,
       cpufreq@zenii.linux.org.uk, linux-kernel@vger.kernel.org,
       linux@dominikbrodowski.net
Subject: Re: cpufreq on-demand governor up_treshold?
Message-ID: <20050314111950.GE2298@poupinou.org>
References: <200503140829.04750.lkml@kcore.org> <42354400.7070500@tremplin-utc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42354400.7070500@tremplin-utc.net>
User-Agent: Mutt/1.5.6+20040907i
From: Bruno Ducrot <ducrot@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2005 at 08:57:52AM +0100, Eric Piel wrote:
> BTW, DaveJ, Dominik, I couldn't find them in the daily-snapshot 
> available at codemonkey.org.uk. Should I worry, or is it just due to 
> some latency between your private trees and the public one?
> 

This happens those days only when I upgrade the LINUX_2_4 branch
(and only because its easier for me to diff between HEAD and LINUX_2_4).

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
