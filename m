Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261493AbVDTI6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbVDTI6Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 04:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbVDTI6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 04:58:16 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:41281 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261493AbVDTI6N convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 04:58:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=XeifrEbkMjOq2nRNNA5h5/qaJMZs5VDBtaI7QSrAH1zpe/38/Ym3iAcVQDHCVtpQsk6O4kuc6c2WXNkng+6alVTby/zhEnywrM/DWraXKx/XLM1Do38VFt7PICxhzL+PmSPC7upTESNY8/OC6zsEezV3SJxZxTu9pvUAf6kmCCc=
Message-ID: <28183df5050420015828ace752@mail.gmail.com>
Date: Wed, 20 Apr 2005 11:58:13 +0300
From: Zvi Rackover <zvirack@gmail.com>
Reply-To: Zvi Rackover <zvirack@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Module that loads new Interrupt Descriptor Table
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
 
  I would like to write a program that monitors various system
parameters in real time. One of these is counting the number of
interrupts. I would like to implement my own interrupt handler so that
each handler counts the number of interrupt of its respective type.
 I have read various guides and tutorials but none of them have
discussed this matter.
 The module is intended to be installed on an Intel architecture machine.
 Any tips or source code would be graciously accepted.
 
 Regards,
  Zvi
