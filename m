Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbUJZT6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbUJZT6x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 15:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261453AbUJZT6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 15:58:47 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:46813 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261434AbUJZT6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 15:58:21 -0400
Subject: Re: [patch 1/2] cciss: cleans up warnings in the 32/64 bit
	conversions
From: James Bottomley <James.Bottomley@SteelEye.com>
To: mikem <mikem@beardog.cca.cpqcorp.net>
Cc: marcelo.tosatti@cyclades.com, Jens Axboe <axboe@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20041026194551.GA21003@beardog.cca.cpqcorp.net>
References: <20041021211718.GA10462@beardog.cca.cpqcorp.net>
	<1098633262.10824.35.camel@mulgrave> 
	<20041026194551.GA21003@beardog.cca.cpqcorp.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 26 Oct 2004 15:57:59 -0400
Message-Id: <1098820685.2061.398.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-26 at 15:45, mikem wrote:
> Which tree are you applying to? This was made from 2.4.28-pre4.

OK, you caught me ... trying to apply a 2.4 patch to a 2.6 tree.  I keep
forgetting that not all patches on linux-scsi are 2.6

James


