Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268544AbUJJXPR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268544AbUJJXPR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 19:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268553AbUJJXPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 19:15:16 -0400
Received: from hacksaw.org ([66.92.70.107]:22173 "EHLO hacksaw.org")
	by vger.kernel.org with ESMTP id S268544AbUJJXPN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 19:15:13 -0400
Message-Id: <200410102315.i9ANF7OI019460@hacksaw.org>
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Subject: Re: udev: what's up with old /dev ? 
In-reply-to: Your message of "Sun, 10 Oct 2004 15:51:43 PDT."
             <87vfdiw5j4.fsf@codesourcery.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 10 Oct 2004 19:15:07 -0400
From: Hacksaw <hacksaw@hacksaw.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>The very first thing init does is open /dev/console, and if it doesn't
>exist the entire boot hangs.

This raises a question: Would it be a useful thing to make a modified init 
that could run udev before it does anything else?
-- 
Melior amare chemia
http://www.hacksaw.org -- http://www.privatecircus.com -- KB1FVD


