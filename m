Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964788AbWFNNIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964788AbWFNNIe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 09:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964905AbWFNNIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 09:08:34 -0400
Received: from lx-ltd.ru ([85.113.143.174]:57241 "EHLO iserver.lx.intercon.ru")
	by vger.kernel.org with ESMTP id S964788AbWFNNId (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 09:08:33 -0400
From: Sergej Pupykin <ps@lx-ltd.ru>
To: linux-kernel@vger.kernel.org
Subject: resubmitting intr urb in 2.4 and 2.6 kernels
Date: Wed, 14 Jun 2006 17:08:32 +0400
Message-ID: <m3lkrzq3zj.fsf@lx-ltd.ru>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

Could anybody explain the reason why intr urb auto resubmitting was removed
from 2.6 kernels?

Or just tell me, it was removed because of some technical problems in it
or only for better architecure?

If it was architecure cleanup, why autoresubmitting was implemented in 2.4?

Thanks.

