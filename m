Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261575AbTCGNym>; Fri, 7 Mar 2003 08:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261576AbTCGNym>; Fri, 7 Mar 2003 08:54:42 -0500
Received: from 205-158-62-158.outblaze.com ([205.158.62.158]:23450 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP
	id <S261575AbTCGNyl>; Fri, 7 Mar 2003 08:54:41 -0500
Message-ID: <20030307140502.95076.qmail@mail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Subodh S" <subodh_s_1975@mail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-scsi@vger.kernel.org
Date: Fri, 07 Mar 2003 09:05:02 -0500
Subject: About dd & make_request
X-Originating-Ip: 133.145.164.4
X-Originating-Server: ws1-3.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When run

dd if=/dev/mydevice of=/dev/null count=10

why does my make_request function get called only five times ??


Thanks and Regards,
Subodh
-- 
__________________________________________________________
Sign-up for your own FREE Personalized E-mail at Mail.com
http://www.mail.com/?sr=signup

