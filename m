Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932454AbWA0KKB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbWA0KKB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 05:10:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbWA0KKB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 05:10:01 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:8144 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932454AbWA0KKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 05:10:00 -0500
Subject: Re:
From: Arjan van de Ven <arjan@infradead.org>
To: sarat <saratkumar.koduri@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <aed62bae0601270205v1156f3cfi3bb4a5857956f641@mail.gmail.com>
References: <aed62bae0601270205v1156f3cfi3bb4a5857956f641@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 27 Jan 2006 11:09:57 +0100
Message-Id: <1138356598.3058.16.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-27 at 15:35 +0530, sarat wrote:
> 
> insmod: error inserting 'firewall.ko': -1 Invalid module format

your module is not compatible with the kernel you are running. In dmesg
or /var/log/messages is more information on the nature of the
incompatibility.


