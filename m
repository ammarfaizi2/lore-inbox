Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264018AbTICBqT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 21:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264013AbTICBqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 21:46:19 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:38409
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S263939AbTICBqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 21:46:17 -0400
Date: Tue, 2 Sep 2003 18:38:32 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Andre Tomt <andre@tomt.net>, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org, mingo@redhat.com
Subject: Re: md: bug in file md.c, line 1440 (2.4.22)
Message-ID: <20030903013832.GD13684@matchmail.com>
Mail-Followup-To: Neil Brown <neilb@cse.unsw.edu.au>,
	Andre Tomt <andre@tomt.net>, linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org, mingo@redhat.com
References: <3F5017CA.4080700@tomt.net> <16213.14893.955734.797630@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16213.14893.955734.797630@gargle.gargle.HOWL>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 03, 2003 at 10:47:41AM +1000, Neil Brown wrote:
> I have not idea how it got the failed flag.
> 
> NeilBrown

Andre, is there any chance you ran a 2.6 kernel on that raid array?
