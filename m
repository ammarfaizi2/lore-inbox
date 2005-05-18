Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262131AbVERJSY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262131AbVERJSY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 05:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262137AbVERJSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 05:18:24 -0400
Received: from fire.osdl.org ([65.172.181.4]:45189 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262131AbVERJSW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 05:18:22 -0400
Date: Wed, 18 May 2005 02:17:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: Norbert Preining <preining@logic.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hostap gone from 2.6.12-rc4-mm2?
Message-Id: <20050518021708.23e9ed51.akpm@osdl.org>
In-Reply-To: <20050518090255.GD28766@gamma.logic.tuwien.ac.at>
References: <20050518090255.GD28766@gamma.logic.tuwien.ac.at>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Norbert Preining <preining@logic.at> wrote:
>
>  The hostap wireless driver is missing from 2.6.12-rc4-mm2. I miss it ;-)

oop, I accidentally commented out the relevant tree.   With luck you can add
http://www.zip.com.au/~akpm/linux/patches/stuff/git-netdev-wifi.patch
