Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030585AbVKIUkL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030585AbVKIUkL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 15:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030774AbVKIUkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 15:40:10 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:29861 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030585AbVKIUkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 15:40:08 -0500
Date: Wed, 9 Nov 2005 12:39:56 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 00/16] Adaptive read-ahead V7
In-Reply-To: <20051109134938.757187000@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0511091239190.4509@schroedinger.engr.sgi.com>
References: <20051109134938.757187000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Would you cc Nick Piggin on the radix tree patches? He has some work in 
progress that may have to be synced between both of you.

