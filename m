Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264639AbUJCFzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264639AbUJCFzF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 01:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264915AbUJCFzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 01:55:04 -0400
Received: from prosun.first.fraunhofer.de ([194.95.168.2]:30852 "EHLO
	prosun.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S264639AbUJCFzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 01:55:02 -0400
To: linux-kernel@vger.kernel.org
Date: Sun, 03 Oct 2004 07:54:57 +0200
From: Soeren Sonnenburg <kernel@nn7.de>
Message-ID: <pan.2004.10.03.05.54.56.769578@nn7.de>
Organization: Local Intranet News
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: suspend no longer works on powerbook since 2.6.9-rc2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the machine hangs _after_ waking up from a suspend to ram cycle with
2.6.9-rc{2,3} but works nicely with 2.6.8.1.

Any ideas ?

Soeren
