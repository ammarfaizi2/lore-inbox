Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261529AbTIBM73 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 08:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbTIBM60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 08:58:26 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:17216 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S261533AbTIBM5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 08:57:49 -0400
Date: Tue, 2 Sep 2003 13:56:25 +0100
From: Dave Jones <davej@redhat.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Ducrot Bruno <ducrot@poupinou.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       cpufreq@www.linux.org.uk
Subject: Re: Athlon XP-M and cpufreq freezing Asus laptop to death
Message-ID: <20030902125625.GA1225@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Pavel Machek <pavel@ucw.cz>, Ducrot Bruno <ducrot@poupinou.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	cpufreq@www.linux.org.uk
References: <20030824164828.GA922@renditai.milesteg.arr> <20030825071009.GH19292@poupinou.org> <20030901200941.GF1358@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030901200941.GF1358@openzaurus.ucw.cz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 01, 2003 at 10:09:42PM +0200, Pavel Machek wrote:
 > > I'm also wondering if those athlons have the same kind of stuff than
 > > the opteron (Dave)?
 > 
 > k8 has similar restriction to small steps, only.

The k8 docs actually specify this though, the k7 ones don't iirc.

                Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
On Mon, Sep 01, 2003 at 10:09:42PM +0200, Pavel Machek wrote:
 > > I'm also wondering if those athlons have the same kind of stuff than
 > > the opteron (Dave)?
 > 
 > k8 has similar restriction to small steps, only.

The k8 docs actually specify this though, the k7 ones don't iirc.

                Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
