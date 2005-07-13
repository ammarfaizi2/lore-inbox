Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262592AbVGMFpL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262592AbVGMFpL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 01:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262559AbVGMFpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 01:45:11 -0400
Received: from zproxy.gmail.com ([64.233.162.195]:25638 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262592AbVGMFpJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 01:45:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=AenTMvYNvpg7bloc6R2ysDz8gF/H+o0ZOg4o9LGvO4ePFz8i0dp0ADAg1wAsTCl1OC/n2T6Xr8sssAVimEjBr7M2btLiz/RrWg4WdvL5KfH3XGNqHTXgaKSDC/2S5GMTtS5zw8E2sPLG/P64zVUy1fjp3gZsHRy2QacIzmhUKIk=
Message-ID: <cd9967e205071222456d542c39@mail.gmail.com>
Date: Wed, 13 Jul 2005 01:45:08 -0400
From: Talal jaafar <talal.jaafar@gmail.com>
Reply-To: Talal jaafar <talal.jaafar@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: SSH/RSH Support for 2.6.12-2
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi All,

    I have recently downloaded the latest stable version of 2.6.12
(2.6.12-2) and I am trying to use either "ssh" or "rsh" to communicate
with another machine. However, I keep getting "Permission Denied", and
from the /var/log/message  it seems that the kernel has some security
enabled that prevents outside communications.  Any help in regard to
this issue would be appreciated?

Thanks,

 Talal
