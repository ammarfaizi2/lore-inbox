Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285404AbRLNQdl>; Fri, 14 Dec 2001 11:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285407AbRLNQdb>; Fri, 14 Dec 2001 11:33:31 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:47109 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S285404AbRLNQdX>;
	Fri, 14 Dec 2001 11:33:23 -0500
Date: Fri, 14 Dec 2001 17:32:59 +0100
From: Jens Axboe <axboe@suse.de>
To: "Alok K. Dhir" <alok@dhir.net>
Cc: "'David S. Miller'" <davem@redhat.com>, lord@sgi.com, gibbs@scsiguy.com,
        LB33JM16@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: highmem, aic7xxx, and vfat: too few segs for dma mapping
Message-ID: <20011214163259.GH1180@suse.de>
In-Reply-To: <20011214161506.GB1180@suse.de> <003101c184bb$93b52e80$9865fea9@pcsn630778>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003101c184bb$93b52e80$9865fea9@pcsn630778>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14 2001, Alok K. Dhir wrote:
> Is this going into the 2.4.17 as well?

It's a 2.5.1-pre11 + bio-pre-X bug fix, so no.

-- 
Jens Axboe

