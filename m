Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266693AbSLWIUN>; Mon, 23 Dec 2002 03:20:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266716AbSLWIUN>; Mon, 23 Dec 2002 03:20:13 -0500
Received: from main.gmane.org ([80.91.224.249]:53722 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S266693AbSLWIUN>;
	Mon, 23 Dec 2002 03:20:13 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Simon Michael <simon@joyful.com>
Subject: Re: [PROBLEM 2.5.52] "bad: scheduling while atomic!" errors during
 boot of 2.5.52, 2.5.51, 2.5.50
Date: Mon, 23 Dec 2002 00:20:44 -0800
Organization: Joyful Systems
Message-ID: <87ptrt2lk3.fsf@joyful.com>
References: <87znqxabgm.fsf@joyful.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@main.gmane.org
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) Emacs/21.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Turning off CONFIG_PREEMPT fixes this problem.


