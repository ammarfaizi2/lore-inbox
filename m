Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964818AbWADRTr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964818AbWADRTr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 12:19:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965070AbWADRTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 12:19:39 -0500
Received: from bay7-f20.bay7.hotmail.com ([64.4.11.45]:14573 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id S964844AbWADRTh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 12:19:37 -0500
Message-ID: <BAY7-F20B9964B2E040C06705307C52F0@phx.gbl>
X-Originating-IP: [82.22.224.216]
X-Originating-Email: [x-list-subscriptions@hotmail.com]
Reply-To: x-lists@cqsat.com
From: "J R" <x-list-subscriptions@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: kernel programming donts
Date: Wed, 04 Jan 2006 09:19:36 -0800
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 04 Jan 2006 17:19:36.0923 (UTC) FILETIME=[09B19AB0:01C61153]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Is there a list of kernel / driver development "donts" documented in 1
place. I'm looking for examples of coding errors that would lead to
leaks,  crashes or vulnerabilities - like using tainted data from
copy_from_user() in an unsafe way. Have these things been collected in 1 
place?

The only thing I could find was the coding style document - but I'm looking 
for more meaty problems than commenting style.

Thanks
-J


--
www.cqsat.com
jr at that domain

_________________________________________________________________
Don’t just search. Find. Check out the new MSN Search! 
http://search.msn.click-url.com/go/onm00200636ave/direct/01/

