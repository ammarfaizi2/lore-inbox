Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272452AbTHIPIj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 11:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272447AbTHIPIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 11:08:39 -0400
Received: from mail.wlanmail.com ([194.100.155.139]:27666 "HELO
	mail.wlanmail.com") by vger.kernel.org with SMTP id S272452AbTHIPIe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 11:08:34 -0400
From: Joonas Koivunen <rzei@mbnet.fi>
Reply-To: rzei@mbnet.fi
To: linux-kernel@vger.kernel.org
Subject: Re: [BUG?] 2.6.0-test3 USB mouse problems
Date: Sat, 9 Aug 2003 18:08:34 +0300
User-Agent: KMail/1.5.1
References: <200308091506.20935.rzei@mbnet.fi>
In-Reply-To: <200308091506.20935.rzei@mbnet.fi>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308091808.34884.rzei@mbnet.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seems that all this was caused because of ACPI. With boot-time acpi=off, mouse 
works. 

-rzei
