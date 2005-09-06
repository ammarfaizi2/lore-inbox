Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932428AbVIFGzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbVIFGzV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 02:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbVIFGzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 02:55:20 -0400
Received: from smtp106.sbc.mail.re2.yahoo.com ([68.142.229.99]:24482 "HELO
	smtp106.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932428AbVIFGzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 02:55:20 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Daniel Phillips <phillips@istop.com>
Subject: Re: GFS, what's remainingh
Date: Tue, 6 Sep 2005 01:55:03 -0500
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, Lars Marowsky-Bree <lmb@suse.de>,
       Andi Kleen <ak@suse.de>, linux clustering <linux-cluster@redhat.com>,
       akpm@osdl.org, linux-fsdevel@vger.kernel.org
References: <20050901104620.GA22482@redhat.com> <200509060005.59578.dtor_core@ameritech.net> <200509060248.47433.phillips@istop.com>
In-Reply-To: <200509060248.47433.phillips@istop.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509060155.04685.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 06 September 2005 01:48, Daniel Phillips wrote:
> On Tuesday 06 September 2005 01:05, Dmitry Torokhov wrote:
> > do you think it is a bit premature to dismiss something even without
> > ever seeing the code?
> 
> You told me you are using a dlm for a single-node application, is there 
> anything more I need to know?
>

I would still like to know why you consider it a "sin". On OpenVMS it is
fast, provides a way of cleaning up and does not introduce single point
of failure as it is the case with a daemon. And if we ever want to spread
the load between 2 boxes we easily can do it. Why would I not want to use
it?

-- 
Dmitry
