Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268778AbUJMPHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268778AbUJMPHw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 11:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268828AbUJMPHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 11:07:51 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:16572 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S268778AbUJMPFn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 11:05:43 -0400
From: Duncan Sands <baldrick@free.fr>
To: Martijn Sipkema <martijn@entmoot.nl>
Subject: Re: waiting on a condition
Date: Wed, 13 Oct 2004 17:05:36 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <02bb01c4b138$8a786f10$161b14ac@boromir> <416D41FF.6080002@redhat.com>
In-Reply-To: <416D41FF.6080002@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410131705.36873.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You may want to look at include/linux/completion.h

Ciao,

Duncan.
