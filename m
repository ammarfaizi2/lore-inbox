Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264930AbTFQU12 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 16:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264932AbTFQU11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 16:27:27 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:34445 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264930AbTFQU1X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 16:27:23 -0400
Subject: Re: patch for common networking error messages
To: "David S. Miller" <davem@redhat.com>
Cc: garzik@pobox.com, shemminger@osdl.org, Valdis.Kletnieks@vt.edu,
       Janice Girouard <girouard@us.ibm.com>,
       Daniel Stekloff <stekloff@us.ibm.com>,
       Larry Kessler <lkessler@us.ibm.com>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, niv@us.ibm.com
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF296D6F92.1C7252A9-ON85256D48.00713BCF@us.ibm.com>
From: Janice Girouard <girouard@us.ibm.com>
Date: Tue, 17 Jun 2003 15:40:48 -0500
X-MIMETrack: Serialize by Router on D01ML063/01/M/IBM(Release 6.0.1 w/SPRs JHEG5JQ5CD, THTO5KLVS6, JHEG5HMLFK, JCHN5K5PG9|March
 27, 2003) at 06/17/2003 16:40:51
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From:  David S. Miller" <davem@redhat.com>
      Date: 06/17/2003 03:27 PM

      On RX, clever RX buffer management is what we need.

What RX buffer management are you proposing?  I'm having a hard time
understanding how  you'll get rid of the copy without support from the
card.

