Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265086AbUFRJj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265086AbUFRJj4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 05:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265087AbUFRJjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 05:39:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:10895 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265063AbUFRJjt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 05:39:49 -0400
Date: Fri, 18 Jun 2004 02:38:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz, vojtech@ucw.cz
Subject: Re: [PATCH 8/11] serio sysfs integration
Message-Id: <20040618023853.5d4ee96a.akpm@osdl.org>
In-Reply-To: <200406180342.11056.dtor_core@ameritech.net>
References: <200406180335.52843.dtor_core@ameritech.net>
	<200406180340.55615.dtor_core@ameritech.net>
	<200406180341.39441.dtor_core@ameritech.net>
	<200406180342.11056.dtor_core@ameritech.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov <dtor_core@ameritech.net> wrote:
>
>   Input: serio sysfs integration

What is the sysfs directory layout, and what do the chosen nodes do?

What design decisions were made when choosing that layout?

Is it so trivial that users don't need any documentation?
