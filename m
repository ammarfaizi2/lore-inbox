Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268547AbUHLMpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268547AbUHLMpG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 08:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268536AbUHLMnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 08:43:24 -0400
Received: from main.gmane.org ([80.91.224.249]:491 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S268547AbUHLMlN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 08:41:13 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Subject: Re: Memory Stick Pro driver
Date: Thu, 12 Aug 2004 14:41:03 +0200
Message-ID: <yw1xu0v8cyw0.fsf@kth.se>
References: <1092312640.13824.89.camel@rade7.e.cs.auc.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 213-187-164-3.dd.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:Kx8lMaF9PKbb//9YWGAtC5Wz9Ek=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Emmanuel Fleury <fleury@cs.auc.dk> writes:

> Hi,
>
> I have a built-in "memory stick" reader on my vaio laptop and I recently
> tried to read a "memory stick pro" stick. I got this messages in the
> /var/log/messages:

[...]

> I was curious to know if the 128Mo limitation is tied to the hardware or
> the software and how much differ these two formats... would it be
> possible to read a "memory stick pro" stick with a "memory stick" reader
> ????

Memory stick pro needs a special reader.  If your reader supports
memory stick pro it most likely has something to that effect printed
on it, or in the documentation.  I've no idea whether the reader in
the vaio laptop supports memory stick pro, but your errors suggest
that it perhaps does not.

-- 
Måns Rullgård
mru@kth.se

