Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262887AbUBZRPX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 12:15:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262892AbUBZRPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 12:15:23 -0500
Received: from fw.osdl.org ([65.172.181.6]:45227 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262887AbUBZRO1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 12:14:27 -0500
From: john cherry <cherry@osdl.org>
Date: Thu, 26 Feb 2004 09:14:25 -0800
Message-Id: <200402261714.i1QHEP725496@build-000.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA64 (2.6.3 - 2004-02-25.17.30) - 5 New warnings (gcc 3.3.1)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

{standard input}:18726: Warning: This is the location of the conflicting usage
{standard input}:18740: Warning: Use of 'cmp4.eq' violates WAW dependency 'PR%, % in 1 - 15' (impliedf), specific resource number is 14
{standard input}:565: Warning: This is the location of the conflicting usage
{standard input}:580: Warning: Only the first path encountering the conflict is reported
{standard input}:580: Warning: Use of 'cmp.eq' violates WAW dependency 'PR%, % in 1 - 15' (impliedf), specific resource number is 14
