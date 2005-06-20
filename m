Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261415AbVFTSNy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261415AbVFTSNy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 14:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbVFTSNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 14:13:54 -0400
Received: from gl177a.glassen.ac ([82.182.223.101]:37058 "HELO findus.dhs.org")
	by vger.kernel.org with SMTP id S261415AbVFTSNx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 14:13:53 -0400
Message-ID: <42B7075C.1090606@findus.dhs.org>
Date: Mon, 20 Jun 2005 20:13:48 +0200
From: =?UTF-8?B?UGV0dGVyIFN1bmRsw7Zm?= <petter.sundlof@findus.dhs.org>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Observation: very low USB performance in 2.6.12 (-2 from agnula)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've observed that USB performance (mass storage) is severaly degraded 
in 2.6.12. Going back to 2.6.10 restores performances to expected levels.
