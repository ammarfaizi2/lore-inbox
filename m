Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264829AbTK3Kvj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 05:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264884AbTK3Kvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 05:51:38 -0500
Received: from mail.gmx.de ([213.165.64.20]:52375 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264829AbTK3Kvi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 05:51:38 -0500
X-Authenticated: #4512188
Message-ID: <3FC9CBB8.7020108@gmx.de>
Date: Sun, 30 Nov 2003 11:51:36 +0100
From: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031116
X-Accept-Language: de-de, de, en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
CC: Jeff Garzik <jgarzik@pobox.com>
Subject: libata and pm
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I wonder whether libata can easily be made compatible with swsup or pmdisk.

Currently my tries stop with the message:

PM: Preparing system for suspend
Stopping tasks: 
=================================================exiting...========
  stopping tasks failed (1 tasks remaining)
Restarting tasks...<6> Strange, katad-1 not stopped
  done


I think that katad belongs to libata.

Cheers,

Prakash

