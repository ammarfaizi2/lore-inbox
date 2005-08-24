Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751452AbVHXEwo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbVHXEwo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 00:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbVHXEwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 00:52:43 -0400
Received: from zproxy.gmail.com ([64.233.162.199]:48812 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751452AbVHXEwn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 00:52:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=pMSqyqAW5bvdqKH9YorV4m3y2VhpxgMo8wGMwjeeWcp32KbtS5hFVfYQvIA4iGQPGo25BHq8HGzE2JPDE+i0S7Simkk9+//pZfSsQkkJzXumBM3wgLUkOfFiPDU/Q25y7eLLjxqlEtMCXjA8hWjj4UGqIO2mOvVK+DWv4U/2siU=
Message-ID: <7cd5d4b4050823215212491130@mail.gmail.com>
Date: Wed, 24 Aug 2005 12:52:42 +0800
From: jeff shia <tshxiayu@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: what does the CDROMREADTOCHDR means?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

in the file of cdrom.c,what dose the ioctl command
CDROMREADTOCHDR&CDROMREADTOCENTRY means?
thank you!
