Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261963AbVCTBGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261963AbVCTBGK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 20:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbVCTBGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 20:06:09 -0500
Received: from mx1.redhat.com ([66.187.233.31]:42900 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261963AbVCTBF5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 20:05:57 -0500
Date: Sat, 19 Mar 2005 20:05:48 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: domen@coderock.org
cc: sds@epoch.ncsc.mil, <linux-kernel@vger.kernel.org>, <adobriyan@mail.ru>
Subject: Re: [patch 1/4] security/selinux/ss/policydb.c: fix sparse warnings
In-Reply-To: <20050319131938.E04781ECA8@trashy.coderock.org>
Message-ID: <Xine.LNX.4.44.0503192005300.26712-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Mar 2005 domen@coderock.org wrote:

>  kj-domen/security/selinux/ss/policydb.c |   35 ++++++++++++++++++--------------
>  1 files changed, 20 insertions(+), 15 deletions(-)

Have you tested these changes?


- James
-- 
James Morris
<jmorris@redhat.com>


