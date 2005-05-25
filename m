Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262228AbVEYNA3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbVEYNA3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 09:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262268AbVEYNA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 09:00:29 -0400
Received: from [83.76.35.193] ([83.76.35.193]:50256 "EHLO
	kestrel.twibright.com") by vger.kernel.org with ESMTP
	id S262228AbVEYNAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 09:00:25 -0400
Date: Wed, 25 May 2005 14:56:09 +0200
From: Karel Kulhavy <clock@twibright.com>
To: linux-kernel@vger.kernel.org
Subject: I2C EEPROM write access
Message-ID: <20050525125609.GA15412@kestrel.twibright.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Orientation: Gay
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Is it possible to use some Linux I2C driver to program an I2C EEPROM,
for example 24C16?

I have noticed only read-only access to "DIMM eeproms". Are they
24C16-alike?

Is there some reason why write driver is not present like users could
inadvertently overwrite their DIMM eeproms? Do these eeproms have a
protection against write?

I am mainly interested in an application where 24C16 is in-circuit
connected to a PC and contents read and wrote (typically poking
at firmware configuration of various devices).

CL<
