Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965195AbVIOFIr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965195AbVIOFIr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 01:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965203AbVIOFIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 01:08:47 -0400
Received: from zproxy.gmail.com ([64.233.162.199]:48697 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965171AbVIOFIq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 01:08:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=uNFlLY+E6gAfQHNiWx25xNIoorsvGBgzBcQQ5moQVmUMoiqIOdf6FPcTQi12EOTMcbKP+sTbRryYXmyKvMCgQDU+F/1tGqXLmKkg6QwQgttR+F/i1wGPeFo3ynw7SIDSuZXDuB5wcRREXkoCf7D/wzqqgs9qJ1EvGaTDZZOZJ/s=
Message-ID: <355e5e5e050914220865dfdf5a@mail.gmail.com>
Date: Thu, 15 Sep 2005 01:08:45 -0400
From: Lukasz Kosewski <lkosewsk@gmail.com>
Reply-To: lkosewsk@gmail.com
To: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH 2.6.14-rc1 2/3] Add disk hotswap support to libata RESEND #3
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       linux-scsi@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 2/3 for libata hotswapping.  The libata hotswap infrastructure,
mark 3.  More comments in patch header.

Luke Kosewski
