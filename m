Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261296AbVC2StH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbVC2StH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 13:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbVC2StG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 13:49:06 -0500
Received: from mx1.redhat.com ([66.187.233.31]:2731 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261296AbVC2Ssn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 13:48:43 -0500
Date: Tue, 29 Mar 2005 13:48:18 -0500
From: Dave Jones <davej@redhat.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Jens Axboe'" <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [patch] optimization: defer bio_vec deallocation
Message-ID: <20050329184818.GA21871@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Chen, Kenneth W" <kenneth.w.chen@intel.com>,
	'Jens Axboe' <axboe@suse.de>, linux-kernel@vger.kernel.org
References: <20050329081305.GG16636@suse.de> <200503291844.j2TIiqg00464@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503291844.j2TIiqg00464@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2005 at 10:44:53AM -0800, Chen, Kenneth W wrote:
 > > Dave Jones wrote on Monday, March 28, 2005 7:00 PM
 > > > If you can't publish results from that certain benchmark due its stupid
 > > > restrictions,
 > 
 > Forgot to thank Dave earlier for his understanding.  I can't even mention the
 > 4 letter acronym for the benchmark.  Sorry, I did not make the rule nor have
 > the power to change the rule.
 
That's ok, I substituted its name for some four letter words of my own. :)
 
		Dave
