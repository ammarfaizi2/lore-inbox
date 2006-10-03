Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030648AbWJCWva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030648AbWJCWva (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 18:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030468AbWJCWva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 18:51:30 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:34202 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030648AbWJCWv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 18:51:29 -0400
Subject: Re: [PATCH] IPC namespace core
From: David Woodhouse <dwmw2@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Kirill Korotaev <dev@openvz.org>, Pavel Emelianov <xemul@openvz.org>,
       Cedric Le Goater <clg@fr.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <20061003154947.7ef2d4a3.akpm@osdl.org>
References: <200610021601.k92G13mT003934@hera.kernel.org>
	 <1159866174.3438.66.camel@pmac.infradead.org>
	 <20061003093505.0bb7bb6a.akpm@osdl.org>
	 <1159912891.27726.3.camel@pmac.infradead.org>
	 <20061003154947.7ef2d4a3.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 03 Oct 2006 23:51:24 +0100
Message-Id: <1159915884.3698.2.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-03 at 15:49 -0700, Andrew Morton wrote:
> Yes - I'll send it along soon.  I just want to have a few hours to convince
> myself that it won't break the whole world if I do...

Seems fair :)

-- 
dwmw2

