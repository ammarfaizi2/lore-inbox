Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263322AbTFDOiO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 10:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263328AbTFDOiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 10:38:14 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:17351 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id S263322AbTFDOiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 10:38:13 -0400
Message-Id: <5.1.0.14.2.20030604163948.00af3d28@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 04 Jun 2003 16:51:30 +0200
To: linux-kernel@vger.kernel.org
From: margitsw@t-online.de (Margit Schubert-While)
Subject: I2C/Sensors 2.5.70
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Seen: false
X-ID: TzhGKUZO8eHKChZKWqTH87XKREI5N6kI5fUCKERyD+ft0bmUH1g2cy@t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is anybody looking at getting $Subject working ?
At the moment i2c-sensor.c never gets compiled which is bad as
it contains i2c_detect needed by all the sensors.
And (assuming sensors works) where does the sensor info(fan, temp etc.)
get put?

Margit

