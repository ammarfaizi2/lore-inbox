Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161464AbWJLGDG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161464AbWJLGDG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 02:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161499AbWJLGDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 02:03:06 -0400
Received: from rosi.naasa.net ([212.8.0.13]:49380 "EHLO rosi.naasa.net")
	by vger.kernel.org with ESMTP id S1161464AbWJLGDD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 02:03:03 -0400
From: Joerg Platte <lists@naasa.net>
Reply-To: jplatte@naasa.net
To: "=?utf-8?q?G=C3=BCnther?= Starnberger" <gst@sysfrog.org>
Subject: Re: Userspace process may be able to DoS kernel
Date: Thu, 12 Oct 2006 08:02:58 +0200
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <474c7c2f0610110954y46b68a14q17b88a5e28ffe8d9@mail.gmail.com>
In-Reply-To: <474c7c2f0610110954y46b68a14q17b88a5e28ffe8d9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200610120802.59077.lists@naasa.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 11. Oktober 2006 18:54 schrieb Günther Starnberger:

> I will upgrade my 2.6.17.6 kernel to 2.6.18 and try to reproduce the
> problem there in the following days (but I fear that I won't have much
> time before the weekend).

Using 2.6.18 does not solve the problem. I can see exactly the same behavior 
with a vanilla and not tainted 2.6.18 kernel.

regards,
Jörg
