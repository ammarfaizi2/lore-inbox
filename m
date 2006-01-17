Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932094AbWAQQCb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbWAQQCb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 11:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbWAQQCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 11:02:31 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41921 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932094AbWAQQCa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 11:02:30 -0500
Subject: Re: RFC [patch 13/34] PID Virtualization Define new task_pid api
From: Arjan van de Ven <arjan@infradead.org>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Dave Hansen <haveblue@us.ibm.com>
In-Reply-To: <20060117155600.GF20632@sergelap.austin.ibm.com>
References: <20060117143258.150807000@sergelap>
	 <20060117143326.283450000@sergelap>
	 <1137511972.3005.33.camel@laptopd505.fenrus.org>
	 <20060117155600.GF20632@sergelap.austin.ibm.com>
Content-Type: text/plain
Date: Tue, 17 Jan 2006 17:02:28 +0100
Message-Id: <1137513748.3005.34.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Is that approach (keeping task->pid as the real pid and dropping the
> task_pid() macro) preferred by all?

it sure is what I think is the best approach



