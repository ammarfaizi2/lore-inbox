Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261194AbVFSNCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbVFSNCI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 09:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261954AbVFSNCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 09:02:08 -0400
Received: from stress.telefonica.net ([213.4.129.135]:10539 "EHLO
	telesmtp4.mail.isp") by vger.kernel.org with ESMTP id S261194AbVFSNCF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 09:02:05 -0400
From: Rafael =?iso-8859-1?q?Rodr=EDguez?= <apt-drink@gulic.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.12: codec_semaphore: semaphore is not ready
Date: Sun, 19 Jun 2005 14:02:02 +0100
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200506191402.02287.apt-drink@gulic.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi. Since I upgraded to 2.6.12, i get messages like

codec_semaphore: semaphore is not ready [0x1][0x
301300]
codec_write 1: semaphoreis not ready for register 0x54

_randomly_ (meaning that in some boots it shows up, but in others doesn't) in 
some init scripts (for example, alsa).

It's an HP pavilion zv5000 (amd64 laptop). Please tell me which more info may 
I supply to trace this. But I repeat, it's not _always_ reproducible.

Regards,

Rafael Rodríguez
