Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbWCHTlZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbWCHTlZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 14:41:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbWCHTlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 14:41:25 -0500
Received: from sorrow.cyrius.com ([65.19.161.204]:65029 "EHLO
	sorrow.cyrius.com") by vger.kernel.org with ESMTP id S932185AbWCHTlY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 14:41:24 -0500
Date: Wed, 8 Mar 2006 19:41:11 +0000
From: Martin Michlmayr <tbm@cyrius.com>
To: Jan Knutar <jk-lkml@sci.fi>
Cc: Anshuman Gholap <anshu.pg@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [future of drivers?] a proposal for binary drivers.
Message-ID: <20060308194110.GB7611@unjust.cyrius.com>
References: <ec92bc30603080135j5257c992k2452f64752d38abd@mail.gmail.com> <200603081151.33349.jk-lkml@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603081151.33349.jk-lkml@sci.fi>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jan Knutar <jk-lkml@sci.fi> [2006-03-08 11:51]:
> > linux installed, i go digicam not working on linux, webcam not
> I thought cameras in general did usb masstorage thing and thus
> worked with anything?

It's fairly common for new cameras, but it's definitely not the case
in general.  There's a program called gphoto2 that can talk to a
number of cameras that don't use USB mass storage, though.
-- 
Martin Michlmayr
tbm@cyrius.com
