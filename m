Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265247AbUGGRbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265247AbUGGRbv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 13:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265249AbUGGRbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 13:31:51 -0400
Received: from web53201.mail.yahoo.com ([206.190.39.217]:37498 "HELO
	web53201.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265247AbUGGRbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 13:31:49 -0400
Message-ID: <20040707171452.9714.qmail@web53201.mail.yahoo.com>
Date: Wed, 7 Jul 2004 14:14:52 -0300 (ART)
From: =?iso-8859-1?q?so=20usp?= <so_usp@yahoo.com.br>
Subject: difference between ports
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I would like to know if there are any difference
between I/O ports such as serial port, parallel port,
keyboard and ide from those ones used by network
interface, such as ssh, ftp, http and telnet. Both can
be accessed by check_region(), request_region() and
release_region() functions? If not, what functions can
be used to access those ports in kernel mode?

Thanks


	
	
		
_______________________________________________________
Yahoo! Mail agora com 100MB, anti-spam e antivírus grátis!
http://br.info.mail.yahoo.com/
