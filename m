Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262007AbUKDAcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262007AbUKDAcc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 19:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262018AbUKDA2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 19:28:52 -0500
Received: from smtp1.sloane.cz ([62.240.161.228]:24264 "EHLO smtp1.sloane.cz")
	by vger.kernel.org with ESMTP id S262007AbUKDA0g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 19:26:36 -0500
From: Michal Semler <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: linux-kernel@vger.kernel.org
Subject: swsuspend and total loss of all data :(((
Date: Thu, 4 Nov 2004 01:26:27 +0100
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200411040126.27613.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

I hibernated without BT donle (CSR based 16.1.1 fw)  plugged into USB port and 
started with it plugged in and kernel after successfully loaded image from 
hdd freezes saying USB device plugged in and info about usb port...

After press reset kernel started recovering ext3 fs, but all my data are 
lost...

PLS fix it in future releases

Thanks

Michal
