Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964987AbWJBU1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964987AbWJBU1N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 16:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964992AbWJBU1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 16:27:13 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:12172 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S964987AbWJBU1M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 16:27:12 -0400
In-Reply-To: <adamz8ews9m.fsf@cisco.com>
Subject: Re: [PATCH 2.6.19-rc1] ehca: fix ehca_probe if module loaded after ib_ipoib
To: Roland Dreier <rdreier@cisco.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       openfabrics-ewg@openib.org, openib-general@openib.org
X-Mailer: Lotus Notes Release 7.0 HF277 June 21, 2006
Message-ID: <OF2EAA258C.4C5B6298-ONC12571FB.0070557F-C12571FB.00706BF1@de.ibm.com>
From: Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>
Date: Mon, 2 Oct 2006 22:29:16 +0200
X-MIMETrack: Serialize by Router on D12ML065/12/M/IBM(Release 6.5.5HF607 | June 26, 2006) at
 02/10/2006 22:29:16
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Looks OK but your mailer mangled the patch.  Please resend in a form
> that can be applied...
> please send unrelated changes as separate patches.
> So this should come as two patches -- one to fix the device
> registration, and one to change your debug formatting.
ok, will resend those two patches soon.

