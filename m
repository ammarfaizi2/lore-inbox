Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290919AbSBZQVF>; Tue, 26 Feb 2002 11:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290965AbSBZQUz>; Tue, 26 Feb 2002 11:20:55 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:65264
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S290919AbSBZQUh>; Tue, 26 Feb 2002 11:20:37 -0500
Date: Tue, 26 Feb 2002 08:21:12 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Christoph Hellwig <hch@ns.caldera.de>
Cc: Dieter N?tzel <Dieter.Nuetzel@hamburg.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-preX: What we really need: -AA patches finally in the tree
Message-ID: <20020226162112.GF4393@matchmail.com>
Mail-Followup-To: Christoph Hellwig <hch@ns.caldera.de>,
	Dieter N?tzel <Dieter.Nuetzel@hamburg.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200202260135.18913.Dieter.Nuetzel@hamburg.de> <200202260707.g1Q77CJ02138@ns.caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200202260707.g1Q77CJ02138@ns.caldera.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2002 at 08:07:12AM +0100, Christoph Hellwig wrote:
> Other -aa parts are much saner and if no one else does it will feed big
> parts to Marcelo.
>

You should talk to Andrew Morton, as he plans to do this also.

> > If we are somewhat risky we put Ingo's GREAT O(1)-scheduler in, too.
> 
> Kill source compatiblity for drivers -> no way.
> 

I thought the internals of the scheduler weren't exposed to the rest of the
kernel...
