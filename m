Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129564AbRCAJ1V>; Thu, 1 Mar 2001 04:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129565AbRCAJ1L>; Thu, 1 Mar 2001 04:27:11 -0500
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:55567 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129564AbRCAJ0x>; Thu, 1 Mar 2001 04:26:53 -0500
X-Apparently-From: <p?gortmaker@yahoo.com>
Message-ID: <3A9E1513.759A8612@yahoo.com>
Date: Thu, 01 Mar 2001 04:23:31 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 3.04 (X11; I; Linux 2.4.2 i486)
MIME-Version: 1.0
To: linux-kernel list <linux-kernel@vger.kernel.org>, linux-parport@torque.net
Subject: Re: [PATCH] smaller parport_pc for non-PCI boxes
In-Reply-To: <3A9DF64F.1255C6C9@yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Forgot to mention that the patch also fixes the warning: 

	`parport_pc_superio_info' defined but not used

for non-PCI, which was the original reason why I was poking around in there.

Paul.


_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

