Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263568AbTKQPTh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 10:19:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263570AbTKQPTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 10:19:37 -0500
Received: from aries.chromosphere.co.uk ([81.168.8.130]:50816 "EHLO
	aries.chromosphere.co.uk") by vger.kernel.org with ESMTP
	id S263568AbTKQPTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 10:19:36 -0500
Subject: Intel SCU RAID + i2o driver (2.4.x)
From: Graeme Coates <graeme@chromosphere.co.uk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 17 Nov 2003 15:19:34 +0000
Message-Id: <1069082375.1538.7.camel@aries.chromosphere.co.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Within drivers/message/i2o/README it states that the Intel SCU cards
failed testing for the i2o driver due to the card "hanging under certain
load patterns" (at least for 2.4.18ac3).

I've been unable to find any details as to the load patterns that causes
this behaviour (in fact there's little information anywhere on this) -
can anyone shed any light on the conditions that cause the card to hang?

TIA

Graeme
--
graeme at chromosphere dot co dot uk




