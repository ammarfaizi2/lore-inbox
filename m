Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751274AbWITHpf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbWITHpf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 03:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbWITHpB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 03:45:01 -0400
Received: from cantor2.suse.de ([195.135.220.15]:27792 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751274AbWITHo7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 03:44:59 -0400
From: Andi Kleen <ak@suse.de>
To: Dmitriy Zavin <dmitriyz@google.com>
Subject: Re: [PATCH 3/4] therm_throt: Make the jiffies compares use the 64bit safe macros.
Date: Wed, 20 Sep 2006 09:43:15 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <11587201623432-git-send-email-dmitriyz@google.com> <11587201621900-git-send-email-dmitriyz@google.com> <1158720162574-git-send-email-dmitriyz@google.com>
In-Reply-To: <1158720162574-git-send-email-dmitriyz@google.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609200943.15477.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 20 September 2006 04:42, Dmitriy Zavin wrote:

Looks good thanks.

(i haven't merged yet though because of the dependencies) 

-Andi
