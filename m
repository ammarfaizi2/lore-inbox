Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264592AbTFIRgy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 13:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264608AbTFIRgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 13:36:54 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:7321 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264592AbTFIRgw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 13:36:52 -0400
Date: Mon, 09 Jun 2003 10:39:05 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>, Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.70-mm6
Message-ID: <46580000.1055180345@flay>
In-Reply-To: <Pine.LNX.4.51.0306091943580.23392@dns.toxicfilms.tv>
References: <20030607151440.6982d8c6.akpm@digeo.com> <Pine.LNX.4.51.0306091943580.23392@dns.toxicfilms.tv>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Monday, June 09, 2003 19:45:58 +0200 Maciej Soltysiak <solt@dns.toxicfilms.tv> wrote:

>> . -mm kernels will be running at HZ=100 for a while.  This is because
>>   the anticipatory scheduler's behaviour may be altered by the lower
>>   resolution.  Some architectures continue to use 100Hz and we need the
>>   testing coverage which x86 provides.
>
> The interactivity seems to have dropped. Again, with common desktop
> applications: xmms playing with ALSA, when choosing navigating through
> evolution options or browsing with opera, music skipps.
> X is running with nice -10, but with mm5 it ran smoothly.

If you don't nice the hell out of X, does it work OK?

M.

