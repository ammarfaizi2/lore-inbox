Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932379AbWIAGGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379AbWIAGGo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 02:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932387AbWIAGGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 02:06:44 -0400
Received: from mx1.redhat.com ([66.187.233.31]:50316 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932379AbWIAGGo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 02:06:44 -0400
X-Originating-IP: [172.16.50.33]
From: "Chris Snook" <csnook@redhat.com>
To: "Vadim Lobanov" <vlobanov@speakeasy.net>, "Willy Tarreau" <w@1wt.eu>
Cc: "Chris Snook" <csnook@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200608312125.14564.vlobanov@speakeasy.net>
Subject: Re: [PATCH 2.4.33.2] enforce RLIMIT_NOFILE in poll()
Date: Fri, 01 Sep 2006 02:08:57 -0400
Message-ID: <20060901.Dlb.27582600@egw.corp.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Mailer: AngleMail for eGroupWare (http://www.egroupware.org) v 1.2.008
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



