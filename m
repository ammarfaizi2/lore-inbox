Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261775AbVDTSFR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbVDTSFR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 14:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261777AbVDTSFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 14:05:17 -0400
Received: from wproxy.gmail.com ([64.233.184.199]:64465 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261775AbVDTSFM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 14:05:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ePcw1NRqDivbPzaxnko/Vftka1lplopZEfaLSnxMxSiuXqu+K9b/iY2LQz2AAlZ9C7deW46gcJhMWRlYR86W1usLtZG9/2F0ZM8uDw1ps6zqPCOyJJUuyGLGtprxPJnFwCEKdBz+1PrUQrvr/o3h1dzcN1oVFPEZmYCwcv4d2BE=
Message-ID: <875fe4a505042011054ac36e00@mail.gmail.com>
Date: Wed, 20 Apr 2005 18:05:12 +0000
From: Francesco Oppedisano <francesco.oppedisano@gmail.com>
Reply-To: Francesco Oppedisano <francesco.oppedisano@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: linux with disabled interrupts
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
i'd like to know how much time does linux kernel run with disabled
interrupts. So i would like to remap the instructions capable of
disabling interrupt to other ones which count how much this time is...
Does already exist a patch or tool capable to give me a magnitude
order of the time spent by the kernel with disables interrupts?
In uniprocessor systems, can i state that the only instruction capable
of disabling interrupts is cli?

Thank u very much

Francesco Oppedisano
