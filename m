Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131082AbQLUVSF>; Thu, 21 Dec 2000 16:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131136AbQLUVRz>; Thu, 21 Dec 2000 16:17:55 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:59154 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S131082AbQLUVRq>; Thu, 21 Dec 2000 16:17:46 -0500
Date: Thu, 21 Dec 2000 14:42:47 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: linux-kernel@vger.kernel.org
Subject: bigphysarea support in 2.2.19 and 2.4.0 kernels
Message-ID: <20001221144247.A10273@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



A question related to bigphysarea support in the native Linux
2.2.19 and 2.4.0 kernels.

I know there are patches for this support, but is it planned for 
rolling into the kernel by default to support Dolphin SCI and 
some of the NUMA Clustering adapters.  I see it there for some 
of the video adapters.

Is this planned for the kernel proper, or will it remain a patch?
At the rate the VM and mm subsystems tend to get updated, I am 
wondering if there's a current version out for this.

Jeff
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
