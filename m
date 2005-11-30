Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750980AbVK3Kls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbVK3Kls (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 05:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbVK3Kls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 05:41:48 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:6221 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750980AbVK3Kls convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 05:41:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=J9GXZ96jlAkk4fNhdyXYMdWwSLNNJXt8EIM1Ox7aMdLOPKgEqQ6wXwcndX/OI74xdpnYhiVpkZb41UEMilcwAxXSsTtR+PmhDcfe4zUaybRsExCL4mjMavhbbMY5qn0Gfq5DZj76MGSkeHP9niu1oTWYWw1TwHqbJVaJ1HcC1h8=
Message-ID: <7a37e95e0511300241j3136e407r1d2395342f5c045b@mail.gmail.com>
Date: Wed, 30 Nov 2005 16:11:47 +0530
From: Deven Balani <devenbalani@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: kiobuf mechanism for SATA drivers
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All!

I am using a SATA driver.

I want to do zero-copy mechanism in the Application using this SATA driver.

Can I use kiobuf mechanism on SCSI Disk drivers.

Is there any source where I can know more on using kiobuf mechanism for SATA.

I came to know SCSI Generic uses this mechanism. Can SCSI Disk driver
do the same.

Regards,
deven
