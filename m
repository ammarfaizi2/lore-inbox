Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263617AbTEDOk3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 10:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263619AbTEDOk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 10:40:29 -0400
Received: from 205-158-62-158.outblaze.com ([205.158.62.158]:11161 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP id S263617AbTEDOk1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 10:40:27 -0400
Message-ID: <20030504145234.83566.qmail@mail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: nmala@mail.com
To: linux-kernel@vger.kernel.org
Cc: linux-scsi@vger.kernel.org
Date: Sun, 04 May 2003 09:52:34 -0500
Subject: Regarding Umount
X-Originating-Ip: 133.145.164.4
X-Originating-Server: ws1-8.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

What exactly does umount write?? Every time I umount my pseudo driver there are two calls to request with readwrite flag set to 1. Haven't been able to find a corresponding write in the trace of umount.

Regards,
Mala
-- 
__________________________________________________________
Sign-up for your own FREE Personalized E-mail at Mail.com
http://www.mail.com/?sr=signup

