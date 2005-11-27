Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751034AbVK0T6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbVK0T6x (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 14:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751038AbVK0T6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 14:58:53 -0500
Received: from xproxy.gmail.com ([66.249.82.205]:49033 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750793AbVK0T6w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 14:58:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:reply-to:x-priority:message-id:to:cc:subject:mime-version:content-type:content-transfer-encoding;
        b=V7cYlvsi0hmCZE4UUwtSoyGVApKskQkG5O6u3bOQsSGj2wWNjgtjJcit6LO8NdZhujg1+3+VGjn+rYe5vFrwKw8GpOCXQadkKFIFQeus8cCxJdXTPcykKnumZNHsJWfPWYSvqCyZ8jw6ExT5p/jzz4LB/94nl7erE0hF2jvJas4=
Date: Sun, 27 Nov 2005 20:58:27 +0100
From: Mateusz Berezecki <mateuszb@gmail.com>
Reply-To: Mateusz Berezecki <mateuszb@gmail.com>
X-Priority: 3 (Normal)
Message-ID: <2510370984.20051127205827@gmail.com>
To: linux-kernel@vger.kernel.org
CC: netdev@vger.kernel.org
Subject: net_device + pci_dev question
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello List!

Having only net_device pointer is it possible to retrieve associated pci_dev
pointer basing on this information only?


kind regards,
Mateusz Berezecki


