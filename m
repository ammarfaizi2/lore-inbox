Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262608AbUKLSr2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262608AbUKLSr2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 13:47:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262609AbUKLSr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 13:47:28 -0500
Received: from rproxy.gmail.com ([64.233.170.203]:26015 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262608AbUKLSr0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 13:47:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=eQUYnnPkr3f2EFpSEXmU/tCgskUUmuQ8pXXzFfXvBalV/VNz5EegNtPal8qjHMUQzK3XM9ajYDuesAzyLo6V0WlTyqmguYXcHYEleJApGyrShi1BSqplEBS7jjMsErrfoCXtjsGHDc7VgfKdv2WTLXJNcLVRb6SyRBQSNGOs2xs=
Message-ID: <d5a95e6d0411121047690a0b51@mail.gmail.com>
Date: Fri, 12 Nov 2004 15:47:25 -0300
From: Diego <foxdemon@gmail.com>
Reply-To: Diego <foxdemon@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Some ideas about % of CPU for a process
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 I´m trying to define a % of cpu for a process, but i don´t have idea
about how i can do it. For example, i said that my process need 40% of
CPU during its lifetime, how can i do it in kernel 2.6?
Thanks for ideas.



Diego.
