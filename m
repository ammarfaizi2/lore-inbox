Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263625AbTDWVes (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 17:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263631AbTDWVes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 17:34:48 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:43705 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263625AbTDWVer
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 17:34:47 -0400
Date: Wed, 23 Apr 2003 14:36:21 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Werner Almesberger <wa@almesberger.net>
cc: Matthias Schniedermeyer <ms@citd.de>, Marc Giger <gigerstyle@gmx.ch>,
       linux-kernel <linux-kernel@vger.kernel.org>, pat@suwalski.net
Subject: Re: [Bug 623] New: Volume not remembered.
Message-ID: <1560860000.1051133781@flay>
In-Reply-To: <20030423183413.C1425@almesberger.net>
References: <21660000.1051114998@[10.10.2.4]> <20030423164558.GA12202@citd.de> <1508310000.1051116963@flay> <20030423183413.C1425@almesberger.net>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Actually, I agree with the submitter. Having the volume default to 0
>> is stupid - userspace tools are all very well, but no substitute for
>> sensible kernel defaults.
> 
> You've obviously never been to a meeting/conference and booted
> a Linux notebook with a kernel that sets things to a non-zero
> default :-)

Irrelevant really, since everyone's proposition is that the distro should
save and restore it from userspace. Which I actually agree with.

I'm more concerned with new installs, and the poor user having no idea
why his sound card "doesn't work". Been there myself. Pain in the ass.

M.

