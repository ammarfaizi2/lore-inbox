Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267508AbUG2Rgd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267508AbUG2Rgd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 13:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267477AbUG2Rdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 13:33:43 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:58038 "HELO ithnet.com")
	by vger.kernel.org with SMTP id S264501AbUG2RbI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 13:31:08 -0400
X-Sender-Authentication: net64
Date: Thu, 29 Jul 2004 19:31:06 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel@vger.kernel.org
Subject: How to increase max number of groups per uid ?
Message-Id: <20040729193106.43d4c515.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

is there a simple way in either 2.4 or 2.6 to get a lot more than 32 groups per
uid?
Imagine a situation with lots of groups (lets assume 5000-10000). It is obvious
that in such a large environment users are commonly members of more than 32
groups.

How can I solve that?
I'd say it should even be possible to be member of all available groups (in
other words completely drop this limit).

Regards,
Stephan

