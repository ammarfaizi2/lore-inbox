Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932518AbVL1Iww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932518AbVL1Iww (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 03:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932519AbVL1Iww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 03:52:52 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:60896 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932518AbVL1Iwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 03:52:51 -0500
Subject: Re: proc_pid_readlink oopses again on 2.6.14.5
From: Arjan van de Ven <arjan@infradead.org>
To: Joshua Kwan <joshk@triplehelix.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <dot96e$e76$1@sea.gmane.org>
References: <dot96e$e76$1@sea.gmane.org>
Content-Type: text/plain
Date: Wed, 28 Dec 2005 09:52:48 +0100
Message-Id: <1135759969.2935.9.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  I'm not running any out-of-tree modules, and unlike last time,
> this is pristine 2.6.14.5.

> Modules linked in: hostap_pci hostap ieee80211_crypt

hehe almost then ;)

