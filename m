Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262573AbUJ0Rhv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262573AbUJ0Rhv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 13:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262580AbUJ0Rfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 13:35:30 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:43167 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262571AbUJ0R0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 13:26:18 -0400
Subject: Re: [BK PATCHES] ide-2.6 update
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200410271213_MC3-1-8D44-F2D8@compuserve.com>
References: <200410271213_MC3-1-8D44-F2D8@compuserve.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1098893896.4304.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 27 Oct 2004 17:18:18 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-10-27 at 17:10, Chuck Ebbert wrote:
>         - accept bad Maxtor drive serial number

This should not be applied. If your drive is no longer reporting its
serial number then its faulty.

