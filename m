Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267721AbUHJUeg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267721AbUHJUeg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 16:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267722AbUHJUef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 16:34:35 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:42425 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S267721AbUHJUco (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 16:32:44 -0400
Date: Tue, 10 Aug 2004 22:29:33 +0200
From: Jens Axboe <axboe@suse.de>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <20040810202932.GB19864@suse.de>
References: <200408101427.i7AERDld014134@burner.fokus.fraunhofer.de> <20040810164947.7f363529.skraw@ithnet.com> <20040810152458.GA1127@lug-owl.de> <20040810153333.GF13369@suse.de> <20040810162951.GC1127@lug-owl.de> <20040810190102.GS26174@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040810190102.GS26174@fs.tum.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10 2004, Adrian Bunk wrote:
> Joerg offers his own non-free program cdrecord-ProDVD with DVD support.
> 
> So why should he ever add DVD support to the GPLed cdrecord, no matter 
> how good the patches are?

It's obvious - to reduce his support load, according to the man that's
his biggest obstacle since the distros add so much broken crap to his
program. He _likes_ to say the distros ship broken crap, why else would
anyone consider getting his "pro" version?

DVD burning is commonplace and has been for years, keeping a basic
feature like that out of the open make no sense.

-- 
Jens Axboe

