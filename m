Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265158AbUETQU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265158AbUETQU4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 12:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265205AbUETQUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 12:20:55 -0400
Received: from i-194-106-33-237.freedom2surf.net ([194.106.33.237]:38358 "EHLO
	outmail.freedom2surf.net") by vger.kernel.org with ESMTP
	id S265158AbUETQUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 12:20:54 -0400
Date: Thu, 20 May 2004 18:21:52 +0100
From: Ian Molton <spyro@f2s.com>
To: linux-kernel@vger.kernel.org
Subject: struct page changes in 2.6.6
Message-Id: <20040520182152.45fb2ce7.spyro@f2s.com>
Organization: The Dragon Roost
X-Mailer: Sylpheed version 0.9.8-gtk2-20031212 (GTK+ 2.2.4; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Im trying to find the reason struct page lost its 'list' field - arm26 depended on it right up to 2.6.5.

-- 
Spyros lair: http://www.mnementh.co.uk/   ||||   Maintainer: arm26 linux

Do not meddle in the affairs of Dragons, for you are tasty and good with ketchup.
