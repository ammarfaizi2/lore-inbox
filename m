Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262658AbSJBXHK>; Wed, 2 Oct 2002 19:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262660AbSJBXHK>; Wed, 2 Oct 2002 19:07:10 -0400
Received: from node-209-133-23-217.caravan.ru ([217.23.133.209]:52229 "EHLO
	mail.tv-sign.ru") by vger.kernel.org with ESMTP id <S262658AbSJBXHK>;
	Wed, 2 Oct 2002 19:07:10 -0400
Message-ID: <3D9B7EC4.D386711D@tv-sign.ru>
Date: Thu, 03 Oct 2002 03:18:28 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] sigfix-2.5.40-A0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Ingo Molnar wrote:
> Fortunately fixing this means the removal of the
> real_blocked field from task_struct.

And what about shared_unblocked field ?
Nobody use it.

Oleg.
