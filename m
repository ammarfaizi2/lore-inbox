Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbWC1USk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbWC1USk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 15:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932132AbWC1USk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 15:18:40 -0500
Received: from 64-30-195-78.dsl.linkline.com ([64.30.195.78]:1006 "EHLO
	jg555.com") by vger.kernel.org with ESMTP id S932138AbWC1USk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 15:18:40 -0500
Message-ID: <442999E5.9070300@jg555.com>
Date: Tue, 28 Mar 2006 12:17:41 -0800
From: Jim Gifford <maillist@jg555.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Kyle Moffett <mrmacman_g4@mac.com>
CC: "Randy.Dunlap" <rdunlap@xenotime.net>, nix@esperi.org.uk, rob@landley.net,
       mmazur@kernel.pl, linux-kernel@vger.kernel.org,
       llh-discuss@lists.pld-linux.org
Subject: Re: State of userland headers
References: <200603141619.36609.mmazur@kernel.pl> <200603231811.26546.mmazur@kernel.pl> <DE01BAD3-692D-4171-B386-5A5F92B0C09E@mac.com> <200603241623.49861.rob@landley.net> <878xqzpl8g.fsf@hades.wkstn.nix> <D903C0E1-4F7B-4059-A25D-DD5AB5362981@mac.com> <20060324150100.ec96dc15.rdunlap@xenotime.net> <E6A4D94A-64AF-46C5-804C-91D661C8C7FE@mac.com>
In-Reply-To: <E6A4D94A-64AF-46C5-804C-91D661C8C7FE@mac.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just to through this out, I'm working on project right now where we want 
to use the latest Kernel Headers, but since LLH is pretty much dead we 
came up with a interim solution until something else gets worked out. 
The script lists below only sanitizes the headers that are needed by 
userspace, there may be some missing, but this has worked on the systems 
I've built up to this point.

http://ftp.jg555.com/headers/headers2

-- 
----
Jim Gifford
maillist@jg555.com

