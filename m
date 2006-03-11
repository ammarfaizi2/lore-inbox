Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752332AbWCKDDz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752332AbWCKDDz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 22:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752333AbWCKDDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 22:03:55 -0500
Received: from namsan.hanyang.ac.kr ([166.104.11.34]:16822 "HELO
	ece.hanyang.ac.kr") by vger.kernel.org with SMTP id S1752331AbWCKDDy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 22:03:54 -0500
Message-ID: <44123D38.60000@ece.hanyang.ac.kr>
Date: Sat, 11 Mar 2006 12:00:08 +0900
From: Moweon Lee <a287848@ece.hanyang.ac.kr>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Hard disk sector remapping
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone!

My name is Moweon Lee from South Korean.

Our team made a new file system which is named by Namsan 
filesystem(Actually it is the name of mountain in Korea and hard to climb.).

Now I'm trying to make bad block management system in that file system.

But I'm not sure about this.

Let me ask you one thing.

When the HDD's sector remapping occurs?

Especially when HDD controller find sector errors in writing phase,

, is it automatically remapped by HDD ? (without notifying it for kernel)

I wanna know it because I have to make some treatment about every sector 
error.

bye~~









