Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271035AbUJUW1T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271035AbUJUW1T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 18:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270998AbUJUW1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 18:27:12 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:2821 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S271019AbUJUWXf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 18:23:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=aM/cHhKljb1+vjpugClXmiU5KL6R9xU/ZJW2i9ttHBR7ZBZDcLt8l+eRLkWIVF6HN4qcTH4uaaqdpju/91Rau+FWfckPOl0exHzTkeF/KW1H05p50jbHo0DcYd6y9hx7huPoyKtNuGncZBTbWpFygn8+PnzQU25MeJqMkZ9XuaE=
Message-ID: <58cb370e0410211523416be4a8@mail.gmail.com>
Date: Fri, 22 Oct 2004 00:23:34 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Eduard Bloch <edi@gmx.de>
Subject: Re: [2.6.9-rc?] long pause after IDE detection
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20041021220438.GA13864@zombie.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041021220438.GA13864@zombie.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> CONFIG_IDE_GENERIC=y

Does disabling this option help?
