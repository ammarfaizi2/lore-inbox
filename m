Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932256AbWGRO4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbWGRO4V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 10:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbWGRO4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 10:56:21 -0400
Received: from daleth.esc.cam.ac.uk ([131.111.64.59]:9992 "EHLO
	aleph.esc.cam.ac.uk") by vger.kernel.org with ESMTP id S932256AbWGRO4U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 10:56:20 -0400
Date: Tue, 18 Jul 2006 15:56:14 +0100
From: James <20@madingley.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: James <20@madingley.org>, linux-kernel@vger.kernel.org
Subject: Re: Bad ext3/nfs DoS bug
Message-ID: <20060718145614.GA27788@circe.esc.cam.ac.uk>
References: <20060717130128.GA12832@circe.esc.cam.ac.uk> <1153209318.26690.1.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1153209318.26690.1.camel@localhost>
User-Agent: Mutt/1.4.1i
X-Mail-Author: fish
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> so I used your exploit and I could reproduce it on every 2.6 kernel, I
> tried so far. 

That must have been a lot of fscks.

> However with a 2.4 kernel I see the error messages, but it
> doesn't get remounted read-only. Did you run tests with 2.4 kernels?

no, I don't have any to hand, but someone is preparing one
now. Is NFS subtree checking on by default in 2.4?

James.
