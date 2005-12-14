Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbVLNIUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbVLNIUp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 03:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932111AbVLNIUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 03:20:45 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:5794 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932105AbVLNIUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 03:20:44 -0500
Subject: Re: [PATCH] fix warning and missing failure handling for
	scsi_add_host in aic7xxx driver
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org,
       "Daniel M. Eischen" <deischen@iworks.interworks.org>,
       Doug Ledford <dledford@redhat.com>
In-Reply-To: <9a8748490512140002s8daf671h6db51bff1c06c834@mail.gmail.com>
References: <200512140007.20046.jesper.juhl@gmail.com>
	 <1134534839.3133.2.camel@mulgrave>
	 <9a8748490512140002s8daf671h6db51bff1c06c834@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 14 Dec 2005 00:20:29 -0800
Message-Id: <1134548429.3262.4.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-14 at 09:02 +0100, Jesper Juhl wrote:
> I'll send a new patch later today when I get home from work.

Actually, the aic79xx has the identical problem, if you want to fix that
too ...

James


