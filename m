Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261835AbTEQVI7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 17:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261849AbTEQVI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 17:08:59 -0400
Received: from 205-158-62-158.outblaze.com ([205.158.62.158]:9426 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP id S261835AbTEQVI6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 17:08:58 -0400
Message-ID: <20030517212152.8385.qmail@mail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Lee Chin" <leechin@mail.com>
To: hahn@physics.mcmaster.ca
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Date: Sat, 17 May 2003 16:21:52 -0500
X-Originating-Ip: 12.234.25.72
X-Originating-Server: ws1-2.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Barring true zero-copy tcp, which I understand requires the NIC and driver to support checksumming and scatter-gather IO, is it possible to and is there anything to be gained by eliminating copying between kernel and user space when sending and receiving over tcp? Is there any support for this in the kernel?

Thanks

Lee
-- 
__________________________________________________________
Sign-up for your own FREE Personalized E-mail at Mail.com
http://www.mail.com/?sr=signup

