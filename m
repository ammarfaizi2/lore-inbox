Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262820AbVCJTB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262820AbVCJTB6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 14:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262996AbVCJTBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 14:01:38 -0500
Received: from rproxy.gmail.com ([64.233.170.202]:48927 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262836AbVCJSw7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 13:52:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=uANuLhs5c9FfvHO/qTHx1xf0G7apI0wgTUMAQTUsLpFq2VnKLk3G9xpD65NHtDtMIO/vI6V6utvXGiD8e2geRCGuFaklHEqqiwuam64zXi8PFfGClRCzWs0lXbz9G1dim3sBAuQ+EmQOj2B+oxwXiNh+OjLqiaeieZFeheGQ+aU=
Message-ID: <9e47339105031010527aa0e3af@mail.gmail.com>
Date: Thu, 10 Mar 2005 13:52:59 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Jens Axboe <axboe@suse.de>
Subject: Re: current linus bk, error mounting root
Cc: Jeff Garzik <jgarzik@pobox.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20050310162918.GD2578@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050309210926.GZ28855@suse.de> <20050310075049.GA30243@suse.de>
	 <9e4733910503100658ff440e3@mail.gmail.com>
	 <20050310153151.GY2578@suse.de>
	 <9e473391050310074556aad6b0@mail.gmail.com>
	 <20050310154830.GB2578@suse.de>
	 <9e47339105031007595b1e0cc3@mail.gmail.com>
	 <20050310160155.GC2578@suse.de>
	 <9e4733910503100818df5fb2@mail.gmail.com>
	 <20050310162918.GD2578@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a big clue, if I build ata_piix in I can boot. If it is a
module I can't. The console output definitely shows that the module is
being loaded.

-- 
Jon Smirl
jonsmirl@gmail.com
