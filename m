Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269085AbUJEQsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269085AbUJEQsT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 12:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269081AbUJEQqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 12:46:05 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:52139 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S270191AbUJEQot
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 12:44:49 -0400
Subject: Re: PROBLEM, PATCH: 2.6.9rc3 build fails with ISDN CAPI
From: Marcel Holtmann <marcel@holtmann.org>
To: emme@emmes-world.de
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200410051734.38741.emme@emmes-world.de>
References: <200410051734.38741.emme@emmes-world.de>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1096994684.20349.78.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 05 Oct 2004 18:44:44 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

> Building Linux 2.6.9-rc3 fails with this message:
> 
> drivers/isdn/capi/capi.c: In Funktion »capi_recv_message«:
> drivers/isdn/capi/capi.c:649: error: `tty' undeclared (first use in this 
> function)
> drivers/isdn/capi/capi.c:649: error: (Each undeclared identifier is reported 
> only once
> drivers/isdn/capi/capi.c:649: error: for each function it appears in.)

this is already fixed. Try 2.6.9-rc3-bk5.

Regards

Marcel


