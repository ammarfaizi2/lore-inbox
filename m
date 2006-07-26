Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751697AbWGZRDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751697AbWGZRDM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 13:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751667AbWGZRDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 13:03:12 -0400
Received: from mail.fieldses.org ([66.93.2.214]:29642 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP
	id S1751085AbWGZRDM (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Wed, 26 Jul 2006 13:03:12 -0400
Date: Wed, 26 Jul 2006 13:02:36 -0400
To: andrea@cpushare.com
Cc: Adrian Bunk <bunk@stusta.de>, Hans Reiser <reiser@namesys.com>,
       Nikita Danilov <nikita@clusterfs.com>, Rene Rebe <rene@exactcode.de>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion
Message-ID: <20060726170236.GD31172@fieldses.org>
References: <200607230920.04129.rene@exactcode.de> <17604.31639.213450.987415@gargle.gargle.HOWL> <20060725123558.GA32243@opteron.random> <44C65931.6030207@namesys.com> <20060726124557.GB23701@stusta.de> <20060726132957.GH32243@opteron.random> <20060726134326.GD23701@stusta.de> <20060726142854.GM32243@opteron.random> <20060726145019.GF23701@stusta.de> <20060726160604.GO32243@opteron.random>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060726160604.GO32243@opteron.random>
User-Agent: Mutt/1.5.11+cvs20060403
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2006 at 06:06:04PM +0200, andrea@cpushare.com wrote:
> JFYI: all statistics only take a sample of the larger space, the whole
> point of having a statistic is because you can't measure the total.
> The smaller the sample compared to the total, the less the stats are
> accurate

Definitely not true in general.  If I wanted to know the gender ratio at
the latest OLS I'd take the results from a sample of a dozen chosen
randomly over the results from a sample of hundreds all taken from the
men's room.

For exactly the same quality of sampling, yes, the larger the better,
but the point of diminishing returns comes pretty quickly.  So given
limited resources it's probably more important to work on the quality of
the sample rather than on its size....

--b.
