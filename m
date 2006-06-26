Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933233AbWFZXf4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933233AbWFZXf4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933151AbWFZXfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 19:35:47 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:32671 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933119AbWFZWer
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:34:47 -0400
From: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Date: Tue, 27 Jun 2006 08:34:46 +1000
Subject: [Suspend2][ 00/20] Prepare image
Message-Id: <20060626223446.4050.9897.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Routines for calculating the contents and metadata of an image, prior
to actually beginning to write it.
