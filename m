Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272562AbTHKNaK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 09:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272570AbTHKNaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 09:30:10 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:47034 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S272562AbTHKNaH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 09:30:07 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 11 Aug 2003 15:29:21 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Michael Buesch <fsdeveloper@yahoo.de>
Cc: video4linux-list@redhat.com,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [2.6-test3] bttv driver doesn't run
Message-ID: <20030811132920.GB10231@bytesex.org>
References: <200308092104.48878.fsdeveloper@yahoo.de> <20030811121546.GA8998@bytesex.org> <200308111419.28312.fsdeveloper@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308111419.28312.fsdeveloper@yahoo.de>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> kernel, because when I tried to configure
> them as modules, I got thousands over thousands
> of unresolved symbols. I tried to resolve them,

modprobe should resolve the dependencies for you ...

  Gerd

