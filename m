Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263060AbUB0RGs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 12:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263059AbUB0RGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 12:06:47 -0500
Received: from fw.osdl.org ([65.172.181.6]:8848 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263060AbUB0RF6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 12:05:58 -0500
From: john cherry <cherry@osdl.org>
Date: Fri, 27 Feb 2004 09:05:56 -0800
Message-Id: <200402271705.i1RH5uH17948@build-000.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA64 (2.6.3 - 2004-02-26.17.30) - 18 New warnings (gcc 3.3.1)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/media/dvb/frontends/stv0299.c:356: warning: unused variable `i'
drivers/media/dvb/frontends/tda1004x.c:1455: warning: cast to pointer from integer of different size
drivers/media/dvb/frontends/tda1004x.c:1458: warning: cast to pointer from integer of different size
drivers/media/dvb/frontends/tda1004x.c:193: warning: `errno' defined but not used
{standard input}:18725: Warning: This is the location of the conflicting usage
{standard input}:18739: Warning: Use of 'cmp4.eq' violates WAW dependency 'PR%, % in 1 - 15' (impliedf), specific resource number is 14
{standard input}:564: Warning: This is the location of the conflicting usage
{standard input}:579: Warning: Only the first path encountering the conflict is reported
{standard input}:579: Warning: Use of 'cmp.eq' violates WAW dependency 'PR%, % in 1 - 15' (impliedf), specific resource number is 14
{standard input}:6919: Warning: This is the location of the conflicting usage
{standard input}:6930: Warning: Only the first path encountering the conflict is reported
{standard input}:6930: Warning: Use of 'ssm' violates WAW dependency 'PSR.i' (impliedf)
{standard input}:7008: Warning: This is the location of the conflicting usage
{standard input}:7019: Warning: Only the first path encountering the conflict is reported
{standard input}:7019: Warning: Use of 'ssm' violates WAW dependency 'PSR.i' (impliedf)
{standard input}:8091: Warning: This is the location of the conflicting usage
{standard input}:8092: Warning: Only the first path encountering the conflict is reported
{standard input}:8092: Warning: Use of 'mov' may violate WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 14
