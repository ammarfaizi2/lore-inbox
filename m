Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932573AbWGTMn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932573AbWGTMn0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 08:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932575AbWGTMn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 08:43:26 -0400
Received: from lx-ltd.ru ([85.113.143.174]:64684 "EHLO iserver.lx.intercon.ru")
	by vger.kernel.org with ESMTP id S932573AbWGTMnZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 08:43:25 -0400
To: linux-kernel@vger.kernel.org
Subject: USB: count of reading urbs
From: Sergej Pupykin <ps@lx-ltd.ru>
Date: 20 Jul 2006 16:43:23 +0400
Message-ID: <m3irls78gk.fsf@lx-ltd.ru>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, All!

Please, tell me. If I submit one urb, can I lost data? (If data comes when
urb callback executed)

