Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030407AbVIITpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030407AbVIITpG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 15:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030390AbVIITpB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 15:45:01 -0400
Received: from kanga.kvack.org ([66.96.29.28]:23007 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1030352AbVIITgR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 15:36:17 -0400
Date: Fri, 9 Sep 2005 15:35:41 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: Luben Tuikov <luben_tuikov@adaptec.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 2.6.13 1/20] aic94xx: Makefile
Message-ID: <20050909193541.GE24673@kvack.org>
References: <4321E335.5010805@adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4321E335.5010805@adaptec.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A single file per patch is not really a patch split up.  Patches should 
stand on their own, leaving the tree in a compilable functioning state 
during each step.

		-ben
