Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751099AbWH2IDW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbWH2IDW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 04:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbWH2IDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 04:03:22 -0400
Received: from szamitogep.hu ([62.77.196.4]:27561 "EHLO www.szamitogep.hu")
	by vger.kernel.org with ESMTP id S1751099AbWH2IDV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 04:03:21 -0400
Message-ID: <3557.213.163.11.81.1156838596.squirrel@www.dunaweb.hu>
Date: Tue, 29 Aug 2006 10:03:16 +0200 (CEST)
Subject: How to determine whether a file was opened O_DIRECT?
From: =?iso-8859-2?Q?B=F6sz=F6rm=E9nyi_Zolt=E1n?= <zboszor@dunaweb.hu>
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.5
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-2
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I would like to run some diagnostics on a database
process and I would like to know what flags it used
for opening its files. Is there any way to get this info?

Thanks in advance,
Zoltán Böszörményi

