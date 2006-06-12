Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751515AbWFLH1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515AbWFLH1F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 03:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbWFLH1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 03:27:05 -0400
Received: from mx1.redhat.com ([66.187.233.31]:62381 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751531AbWFLH1C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 03:27:02 -0400
Date: Mon, 12 Jun 2006 00:26:50 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Patch for atkbd.c from Ubuntu
Message-Id: <20060612002650.6f61a83b.zaitcev@redhat.com>
In-Reply-To: <200606120049.13974.dtor_core@ameritech.net>
References: <20060524113139.e457d3a8.zaitcev@redhat.com>
	<200605290059.32302.dtor_core@ameritech.net>
	<20060528233420.9de79795.zaitcev@redhat.com>
	<200606120049.13974.dtor_core@ameritech.net>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.17; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jun 2006 00:49:13 -0400, Dmitry Torokhov <dtor_core@ameritech.net> wrote:

> I am backpedaling on that problem. It seems that HANGUEL/HANJA scancodes are
> pretty well-defined an we need to make them work properly. Please look here
> for the proposed patch:
> 
> 	http://bugzilla.kernel.org/show_bug.cgi?id=6642

Sounds good. Hangul is usually spelled without 'E' in the West, but
I am not Korean, I can't know what is right.

-- Pete
