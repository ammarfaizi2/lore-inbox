Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262171AbTIEJX0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 05:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262261AbTIEJXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 05:23:25 -0400
Received: from poup.poupinou.org ([193.253.14.96]:31758 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP id S262171AbTIEJXW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 05:23:22 -0400
Date: Fri, 5 Sep 2003 11:23:10 +0200
To: Dave Jones <davej@redhat.com>, Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       cpufreq@www.linux.org.uk
Subject: Re: Athlon XP-M and cpufreq freezing Asus laptop to death
Message-ID: <20030905092310.GP4401@poupinou.org>
References: <20030824164828.GA922@renditai.milesteg.arr> <20030825071009.GH19292@poupinou.org> <20030901200941.GF1358@openzaurus.ucw.cz> <20030902125625.GA1225@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030902125625.GA1225@redhat.com>
User-Agent: Mutt/1.5.4i
From: Ducrot Bruno <ducrot@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 02, 2003 at 01:56:25PM +0100, Dave Jones wrote:
> On Mon, Sep 01, 2003 at 10:09:42PM +0200, Pavel Machek wrote:
>  > > I'm also wondering if those athlons have the same kind of stuff than
>  > > the opteron (Dave)?
>  > 
>  > k8 has similar restriction to small steps, only.
> 
> The k8 docs actually specify this though, the k7 ones don't iirc.
> 

Hem, some of vid/fid combinations cant be used .  But
there is no verifications of such in powernow-k7 though.
Since there is a need to change only one at a time...

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
