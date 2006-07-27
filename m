Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751315AbWG0OGf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbWG0OGf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 10:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbWG0OGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 10:06:35 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:18189 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1751315AbWG0OGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 10:06:34 -0400
Message-ID: <44C8C804.7050805@shadowen.org>
Date: Thu, 27 Jul 2006 15:04:52 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc2-mm1
References: <20060727015639.9c89db57.akpm@osdl.org>
In-Reply-To: <20060727015639.9c89db57.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seems that this one is eating /dev/null's during 'make' phase of a 
build.  Am trying to track down whats changed.

-apw
