Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272360AbTHNN4X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 09:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272366AbTHNN4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 09:56:23 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:53509 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id S272360AbTHNN4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 09:56:22 -0400
Date: Thu, 14 Aug 2003 15:56:09 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test3-mm1 /proc/ikconfig/config adds space after numbers
Message-ID: <20030814135609.GA29328@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.0-test3-mm1:
After every number in /proc/ikconfig/config there's an extra space.

This leads to messages like

.config:244: symbol value '1 ' invalid for
SCSI_SYM53C8XX_DMA_ADDRESSING_MODE

and lots more.

Kind regards,
Jurriaan
-- 
Genius untempered by ethics is a deadly commodity.
	Iain Irvine - A Shadow on the Glass
Debian (Unstable) GNU/Linux 2.6.0-test3-mm1 4276 bogomips load av: 1.14 1.11 1.09
