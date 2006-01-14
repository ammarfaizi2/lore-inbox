Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751118AbWANMqF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbWANMqF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 07:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbWANMqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 07:46:05 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:10402 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751118AbWANMqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 07:46:04 -0500
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
Date: Sat, 14 Jan 2006 14:46:02 +0200
Message-Id: <20060114122249.246354000@localhost>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, manfred@colorfullife.com
Subject: [patch 00/10] slab updates
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

This patchset contains slab updates from various people. Please apply.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
--

 slab.c |  601 +++++++++++++++++++++++++++++++++++------------------------------
  1 file changed, 331 insertions(+), 270 deletions(-)

