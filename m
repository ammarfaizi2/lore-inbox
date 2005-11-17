Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751032AbVKQPAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032AbVKQPAl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 10:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751031AbVKQPAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 10:00:41 -0500
Received: from amdext4.amd.com ([163.181.251.6]:57731 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S1751021AbVKQPAk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 10:00:40 -0500
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
Date: Thu, 17 Nov 2005 08:04:04 -0700
From: "Jordan Crouse" <jordan.crouse@amd.com>
To: "Mikael Pettersson" <mikpe@csd.uu.se>
cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH:  Fix poor pointer math in devinet_sysctl_register
Message-ID: <20051117150404.GA2612@cosmic.amd.com>
References: <20051116232345.GA872@cosmic.amd.com>
 <17276.24851.194332.590736@alkaid.it.uu.se>
MIME-Version: 1.0
In-Reply-To: <17276.24851.194332.590736@alkaid.it.uu.se>
User-Agent: Mutt/1.5.11
X-WSS-ID: 6F62448E1M41015349-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is the same code which broke due to a known gcc-4.0.0 bug:
> <http://gcc.gnu.org/bugzilla/show_bug.cgi?id=21173>. If you're
> indeed using gcc-4.0.0, then it's time to upgrade.
> 
Indeed, I am using 4.0.0, so may indeed be it.  I'll upgrade and take
another shot at it.

Thanks,

Jordan

-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>

