Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263132AbTENWpD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 18:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263139AbTENWpD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 18:45:03 -0400
Received: from ecs.syr.edu ([128.230.208.14]:24022 "EHLO erebus.ecs.syr.edu")
	by vger.kernel.org with ESMTP id S263132AbTENWpC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 18:45:02 -0400
Date: Wed, 14 May 2003 18:57:51 -0400 (EDT)
From: Kyung-suk Lhee <klhee@ecs.syr.edu>
X-X-Sender: klhee@apollo
To: linux-kernel@vger.kernel.org
Subject: header files for kernel module programming
Message-ID: <Pine.GSO.4.44.0305141848140.4620-100000@apollo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, a newbie question for kernel module programming ...

In my kernel module function, I want to call directly
sys_newstat(), sys_link() etc. Which header file I should
include? Other kernel functions I need to call are
namei() and kernel_lock(). Which header files are
relevant to those functions?

Generally, where can I get a documentation for this?
(or which directory in the linux source distribution)

thanks,
kyungsuk Lhee
klhee@syr.edu

