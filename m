Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751365AbWBKJ7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbWBKJ7Y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 04:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbWBKJ7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 04:59:24 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:3668 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751365AbWBKJ7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 04:59:23 -0500
Date: Sat, 11 Feb 2006 10:59:10 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: davej@redhat.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Fix s390 build failure.
Message-ID: <20060211095910.GB9316@osiris.boeblingen.de.ibm.com>
References: <20060210200425.GA11913@redhat.com> <Pine.LNX.4.64.0602101314082.19172@g5.osdl.org> <20060210212711.GD31949@redhat.com> <20060211094603.GA9316@osiris.boeblingen.de.ibm.com> <20060211015114.28b06319.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060211015114.28b06319.akpm@osdl.org>
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've been a bit sluggish with the s390 patches while waiting for you and
> Christoph to sort things out.  I'm thinking of holding off on
> s390-add-missing-validation-for-dasd-discipline-specific-ioctls.patch and
> s390-cleanup-of-dasd-eer-module.patch.

Just don't send them for now. I hope the dasd guys here and Christoph will
come to a conclusion on how to go on with this soon.

Thanks,
Heiko
