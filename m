Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261195AbVBLUdn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbVBLUdn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 15:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbVBLUdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 15:33:43 -0500
Received: from main.gmane.org ([80.91.229.2]:19939 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261195AbVBLUdH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 15:33:07 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz>
Subject: Re: bttv: tuner: i2c i/o error: rc == -121 (should be 4)
Date: Sat, 12 Feb 2005 21:22:17 +0100
Message-ID: <culodt$u8s$2@sea.gmane.org>
References: <f396da08050212112363a4b5cf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 195.70.138.133
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
In-Reply-To: <f396da08050212112363a4b5cf@mail.gmail.com>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
X-Gmane-MailScanner: Found to be clean
X-Gmane-MailScanner: Found to be clean
X-MailScanner-From: glk-linux-kernel@m.gmane.org
X-MailScanner-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Margus Eha wrote:
> Tv card works but i can't change channel. Something goes wrong in tuner.c
> when tvtime program tries to change frequency. In /var/log/messages i can find
> tuner: i2c i/o error: rc == -121 (should be 4). 
> 
> Las working version i tried was 2.6.11-rc2
> Both 2.6.11-rc3-mm1 and Both 2.6.11-rc3-mm2 are not working.
> 
> If kernel conf is needed i can send.

http://bugme.osdl.org/show_bug.cgi?id=4171

-- 
JM

