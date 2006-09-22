Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964905AbWIVXH6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964905AbWIVXH6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 19:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964904AbWIVXH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 19:07:58 -0400
Received: from hansmi.home.forkbomb.ch ([213.144.146.165]:53788 "EHLO
	hansmi.home.forkbomb.ch") by vger.kernel.org with ESMTP
	id S964846AbWIVXH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 19:07:57 -0400
Date: Sat, 23 Sep 2006 01:07:55 +0200
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: Andrew Morton <akpm@osdl.org>
Cc: Olaf Hering <olaf@aepfle.de>, linux-kernel@vger.kernel.org,
       linux-fbdev-devel@lists.sourceforge.net,
       "Antonino A. Daplas" <adaplas@pol.net>,
       Daniel R Thompson <daniel.thompson@st.com>,
       Jon Smirl <jonsmirl@gmail.com>
Subject: Re: backlight: oops in __mutex_lock_slowpath during head /sys/class/graphics/fb0/* in 2.6.18
Message-ID: <20060922230755.GA9548@hansmi.ch>
References: <20060921121952.GA16927@aepfle.de> <20060921123742.ec225cc2.akpm@osdl.org> <20060921215620.GA9518@hansmi.ch> <20060922112622.GA26724@aepfle.de> <20060922160255.b97f2887.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060922160255.b97f2887.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2006 at 04:02:55PM -0700, Andrew Morton wrote:
> Still looks like a bit of a mess, but I assume that's expected.

> Michael, I take it that patch was final?

For now, yes. Thanks for adding it to -mm.
