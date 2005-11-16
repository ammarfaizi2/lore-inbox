Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030354AbVKPOuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030354AbVKPOuM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 09:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030355AbVKPOuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 09:50:12 -0500
Received: from xproxy.gmail.com ([66.249.82.206]:49469 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030354AbVKPOuK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 09:50:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=QMaJBT1XwCoUg0klTCUJyS+eGbcBfLfYSH62qPOeew84e2nRNRna40ifk7n+AucMqkdq3g8GZCZRtxSv0R+/2lXypf2y9KjAfqgNnNFyp71zP9Vo2W5BxqdEw4ginZkeiuIL65z1m0ZOaaUKz6bNhbrid/FMrHFPi+u++HJQEiw=
Message-ID: <5bdc1c8b0511160650k4a9e0575h29403a5de47af952@mail.gmail.com>
Date: Wed, 16 Nov 2005 06:50:10 -0800
From: Mark Knecht <markknecht@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.15-rc1 - NForce4 PCI-E agpgart support?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   I downloaded and built 2.6.15-rc1 as a test assuming Ingo will
release -rt support for this one of these days. (No rush Ingo!) It
booted on my AMD64 machine and is running fine AFAICT.

   One thing I was expecting to see was agpgart support for the
NForce4 chipset. Is this something that's coming or am I missing where
the configuration is done?

   I have a PCI-Express based Radeon and would like to get better
performance. I'm presuming that agpgart support is part of that
solution? (As it was on earlier architectures?)

Thanks,
Mark
