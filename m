Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265422AbUATMEU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 07:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265423AbUATMEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 07:04:20 -0500
Received: from mail1-106.ewetel.de ([212.6.122.106]:35488 "EHLO
	mail1.ewetel.de") by vger.kernel.org with ESMTP id S265422AbUATMET
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 07:04:19 -0500
Date: Tue, 20 Jan 2004 13:04:11 +0100 (CET)
From: Pascal Schmidt <der.eremit@email.de>
To: Andries.Brouwer@cwi.nl
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix for ide-scsi crash
In-Reply-To: <UTC200401200944.i0K9iRE25868.aeb@smtp.cwi.nl>
Message-ID: <Pine.LNX.4.44.0401201302470.1014-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jan 2004 Andries.Brouwer@cwi.nl wrote:

> And then there is the read-only part that must be removed.

Not a problem for ide-cd, it already supports writing for DVD-RAM,
and in -mm also packet writing.

-- 
Ciao,
Pascal

