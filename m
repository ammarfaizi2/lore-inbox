Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751161AbVJZJhZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbVJZJhZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 05:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbVJZJhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 05:37:25 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:8619 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751161AbVJZJhY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 05:37:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=JHVcEYJ7qAkSbJs3HiV+ZBuLraQIgSVdDdQUSSQt8IXgL0jKxH1/m0jVbYP5TNpSZldihnWMMOEibINgDetUNLwCO/OEJOq5/BHCcBd0nN1esdh8qztOTHwptD8Ao2U5qH35Ii3F/VFj0UK+hOo3Joczb7nexqHLKE5VbDXXhgc=
Message-ID: <f69849430510260237g77c65cbbg69af3cf7342ecdf5@mail.gmail.com>
Date: Wed, 26 Oct 2005 02:37:22 -0700
From: kernel coder <lhrkernelcoder@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Porting oprofile to 2.4.32 kernel
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
   I'm trying to port oprofile to 2.4.32 kernel running on MIPS
board.From where i can get the oprofile patch for other boards so that
i can use that patch as a guide for my own port.

lhrkernelcoder
