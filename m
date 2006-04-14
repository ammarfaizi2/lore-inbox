Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751287AbWDNQ55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbWDNQ55 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 12:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbWDNQ55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 12:57:57 -0400
Received: from nproxy.gmail.com ([64.233.182.191]:49034 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751287AbWDNQ55 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 12:57:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=bB7Zt5UBZbDbKlCXAx7dtAPber5qovkh1/7Hz0T4FpF633+zePIpXfubXk1oAPrKO6MloaOnUtmz05rSDVhVc/d/x6xykP2KCTTfx/OgPydkzmpWLDIKiGK3DYwrvuBAff9jwIKWXRqrD2AS3cjY9TwYlVzpEEKJj6LgKwkTcvE=
Message-ID: <32124b660604140957y106f1150sd80e95a046a9c26b@mail.gmail.com>
Date: Fri, 14 Apr 2006 18:57:55 +0200
From: "Ojciec Rydzyk" <69rydzyk69@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: IRQ probe failed
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
I was helping my friend to compile a kernel remotely. And the only
error he gets is:
hda: IRQ probe failed (0xfcfa)
hdb: IRQ probe failed
hdc: IRQ probe failed

Please help, what is wrong with the configuration?

Greetings,
Jacek Jablonski
