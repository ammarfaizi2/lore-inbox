Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbUCWRrb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 12:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262741AbUCWRrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 12:47:31 -0500
Received: from mx2.ews.uiuc.edu ([130.126.161.238]:36772 "EHLO
	mx2.ews.uiuc.edu") by vger.kernel.org with ESMTP id S262730AbUCWRra
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 12:47:30 -0500
From: "Wanghong Yuan" <wyuan1@ews.uiuc.edu>
To: <linux-kernel@vger.kernel.org>
Subject: how to switch wireless card states, thanks
Date: Tue, 23 Mar 2004 11:47:29 -0600
Message-ID: <000001c410fe$e9542540$e6f7ae80@ad.uiuc.edu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am current doing a project to save the energy consumed by the wireless
network card. I know IEEE 802.11 supports a PSM mode. But I need to go a
further step: explicitly switching the card states (e.g., from idle to
sleep or from sleep to active) in the kernel or user space. Can anyone
help me on this? Thanks and appreciate your help.

Wanghong

