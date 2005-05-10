Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261573AbVEJIIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261573AbVEJIIg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 04:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261576AbVEJIIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 04:08:35 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:31883 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261573AbVEJIIc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 04:08:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=INRnIV7TbDMoksw1mSCrI5a7HoL+L+lKBV+tf9uA++/jWh9g6tkB1MScMNkawdYP3HmoW/ms6sd3FusKcOD4QwEM+OobGDX2yDmRSU7wDy2cSOjPJqLC971zfZLBqnaSG6Oyprl3xxlI4WUBZVUOeWKtBacX1jE1zDke1Yweuz4=
Message-ID: <5eb4b0650505100108179ba1b6@mail.gmail.com>
Date: Tue, 10 May 2005 16:08:30 +0800
From: KC <kcc1967@gmail.com>
Reply-To: KC <kcc1967@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: kernel 2.6.x driver compiler options
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Instead of using Linux kconfig build system, can someone tell me
what's the compiler options used to build a device driver (.ko file) ?

Or, how can I integrate kconfig with GNU tool chain (automake, autoconf ...)

Thanks
KC
kccheng@LinuxDAQ-Labs.org
