Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264375AbUEMS1a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264375AbUEMS1a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 14:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264373AbUEMS1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 14:27:30 -0400
Received: from mta-fs-be-04.sunrise.ch ([194.158.229.33]:9727 "EHLO
	mail-fs.sunrise.ch") by vger.kernel.org with ESMTP id S264379AbUEMS0w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 14:26:52 -0400
From: Antille Julien <julien.antille@eivd.ch>
To: linux-kernel@vger.kernel.org
Subject: keventd takes 99% of CPU when laptop lid is closed
Date: Thu, 13 May 2004 20:26:46 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200405132026.46505.julien.antille@eivd.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2.4.26, 2.6.5 and 2.6.6, the kernel process keventd takes 99% of CPU when 
my laptop's lid is closed. It comes back to normal when I open it again.
Laptop is a DELL Inspirion 2650.

This problem did not occure with <=2.4.25 or <= 2.6.4

Any clue ?

Julien Antille
