Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932542AbWAFRTn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932542AbWAFRTn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 12:19:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932640AbWAFRTm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 12:19:42 -0500
Received: from mail.portrix.net ([212.202.157.208]:55769 "EHLO
	zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S932633AbWAFRTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 12:19:40 -0500
Message-ID: <43BEA677.8090800@ppp0.net>
Date: Fri, 06 Jan 2006 18:18:47 +0100
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051017 Thunderbird/1.0.7 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/17] FRV: Permit compilation with allmodconfig
References: <dhowells1136564974@warthog.cambridge.redhat.com>
In-Reply-To: <dhowells1136564974@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:
> The attached patches permit the FRV arch to be mostly compiled with
> allmodconfig, barring compiler errors.

What are the required and known working gcc and binutils versions
for that?

Thanks,

Jan

