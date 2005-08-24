Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932332AbVHXWc4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbVHXWc4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 18:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbVHXWc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 18:32:56 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:40951 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S932332AbVHXWcz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 18:32:55 -0400
Message-ID: <430CF57B.2090000@mvista.com>
Date: Wed, 24 Aug 2005 15:32:27 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>
Subject: RT patch
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

Do you keep the RT patch as one slab or is it a series of patches 
(presumably managed by quilt)?

If the latter, could you make a break out available, much as Andrew does 
for the mm kernels?

This would make it much easier to isolate the various "neat" things and, 
possibly, send them on to Andrew/ Linus or where ever.
-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
